/**
 * Configurable logger for inbound REST integrations.
 *
 * Behaviour is set per integration in Integration_Log_Setting__mdt (DeveloperName = integration class
 * name, falling back to the "Default" record), so logging can be turned up or down in Setup without a
 * deployment.
 *
 * Entries are published as Integration_Log_Event__e, which is configured to "Publish Immediately": a
 * failed call is still logged even though its own transaction rolls back. IntegrationLogEventTrigger
 * stores the events as Integration_Log__c records.
 *
 * Usage:
 *     IntegrationLogger log = new IntegrationLogger('MyIntegration');
 *     log.logRequest(RestContext.request);
 *     try {
 *         String result = ...;          // call log.debug(...) / log.recordResult(...) along the way
 *         log.finish(result);
 *         return result;
 *     } catch (Exception e) {
 *         log.fail(e);
 *         throw e;
 *     }
 *
 * Logging never throws: any problem inside the logger is written to the debug log and swallowed so the
 * integration itself is unaffected.
 */
public without sharing class IntegrationLogger {

    public static final String LEVEL_ERROR = 'ERROR';
    public static final String LEVEL_INFO = 'INFO';
    public static final String LEVEL_DEBUG = 'DEBUG';

    public static final String STATUS_SUCCESS = 'Success';
    public static final String STATUS_PARTIAL = 'Partial Success';
    public static final String STATUS_FAILED = 'Failed';
    public static final String STATUS_NO_DATA = 'No Data';

    public static final String ACTION_INSERT = 'Insert';
    public static final String ACTION_UPDATE = 'Update';

    @TestVisible private static final Integer MAX_LONG_TEXT = 131072;
    private static final Integer MAX_ERROR_TEXT = 32768;
    private static final String TRUNCATED = '...[truncated]';
    private static final String DEFAULT_SETTING = 'Default';
    private static final String DEFAULT_SENSITIVE_FIELDS = 'Email,alt_email,emailId,primary_phone,mobile,fname,lname,Address';

    // Fields copied one-to-one from Integration_Log_Event__e to Integration_Log__c.
    private static final List<String> LOG_FIELDS = new List<String>{
        'Integration_Name__c', 'Status__c', 'Log_Level__c', 'Request_Id__c', 'Request_URI__c', 'HTTP_Method__c',
        'Remote_Address__c', 'Running_User__c', 'Records_Received__c', 'Records_Inserted__c', 'Records_Updated__c',
        'Records_Failed__c', 'Execution_Time_ms__c', 'Limits_Summary__c', 'Error_Message__c', 'Stack_Trace__c',
        'Request_Body__c', 'Response_Body__c', 'Record_Results__c', 'Debug_Log__c'
    };

    @TestVisible private static Integration_Log_Setting__mdt settingOverride;

    private final String integrationName;
    private final Integration_Log_Setting__mdt setting;
    private final String level;
    private final Long startTime = System.currentTimeMillis();
    private final Integration_Log_Event__e evt = new Integration_Log_Event__e();
    private final List<String> debugLines = new List<String>();
    private final List<Map<String, Object>> recordResults = new List<Map<String, Object>>();

    private Integer debugLength = 0;
    private String requestBody;
    private Integer recordsReceived;
    private Integer inserted = 0;
    private Integer updated = 0;
    private Integer failed = 0;
    private String firstFailure;
    private Boolean completed = false;

    public IntegrationLogger(String integrationName) {
        this.integrationName = integrationName;
        this.setting = loadSetting(integrationName);
        this.level = String.isBlank(setting.Log_Level__c) ? LEVEL_ERROR : setting.Log_Level__c;
    }

    public Boolean isEnabled() {
        return setting.Enabled__c == true;
    }

    public Boolean isDebugEnabled() {
        return isEnabled() && level == LEVEL_DEBUG;
    }

    /** Captures URI, method, caller IP and (if configured) the raw body of the inbound request. */
    public void logRequest(RestRequest req) {
        if (req == null) {
            return;
        }
        evt.Request_URI__c = req.requestURI == null ? null : req.requestURI.left(255);
        evt.HTTP_Method__c = req.httpMethod;
        evt.Remote_Address__c = req.remoteAddress;
        if (setting.Log_Request_Body__c == true && req.requestBody != null) {
            requestBody = req.requestBody.toString();
        }
    }

    public void setRecordsReceived(Integer count) {
        recordsReceived = count;
        debug('Records received: ' + count);
    }

    /** Step-by-step troubleshooting detail. Kept on the log only at DEBUG level; always sent to System.debug. */
    public void debug(String message) {
        System.debug(LoggingLevel.DEBUG, '[' + integrationName + '] ' + message);
        if (!isDebugEnabled() || debugLength >= MAX_LONG_TEXT) {
            return;
        }
        String line = System.now().formatGmt('HH:mm:ss.SSS') + ' ' + message;
        debugLines.add(line);
        debugLength += line.length() + 1;
    }

    /**
     * Outcome of one record. key identifies the record to the caller (the email address for these
     * integrations) and is masked when masking is on. Failures are always kept; successes only at DEBUG.
     */
    public void recordResult(String key, String action, Boolean success, String message) {
        if (success) {
            if (action == ACTION_INSERT) {
                inserted++;
            } else {
                updated++;
            }
        } else {
            failed++;
            if (firstFailure == null) {
                firstFailure = message;
            }
            System.debug(LoggingLevel.ERROR, '[' + integrationName + '] ' + action + ' failed: ' + message);
        }
        if (!success || isDebugEnabled()) {
            recordResults.add(new Map<String, Object>{
                'key' => maskingOn() ? maskValue(key) : key,
                'action' => action,
                'success' => success,
                'message' => message
            });
        }
    }

    /** Records the outcome of a Database.insert/update call, including every error's status code and fields. */
    public void recordResult(String key, String action, Database.SaveResult sr) {
        if (sr.isSuccess()) {
            recordResult(key, action, true, sr.getId());
            return;
        }
        List<String> errors = new List<String>();
        for (Database.Error err : sr.getErrors()) {
            errors.add(err.getStatusCode() + ': ' + err.getMessage()
                + (err.getFields().isEmpty() ? '' : ' ' + err.getFields()));
        }
        recordResult(key, action, false, String.join(errors, '; '));
    }

    /** Call once when the integration returns normally. */
    public void finish(String response) {
        if (completed) {
            return;
        }
        String status;
        if (failed > 0) {
            status = (inserted + updated == 0) ? STATUS_FAILED : STATUS_PARTIAL;
            evt.Error_Message__c = truncate(failed + ' record(s) failed. First error: ' + firstFailure, MAX_ERROR_TEXT);
        } else if (recordsReceived == null || recordsReceived == 0) {
            status = STATUS_NO_DATA;
        } else {
            status = STATUS_SUCCESS;
        }
        if (setting.Log_Response_Body__c == true) {
            evt.Response_Body__c = response;
        }
        publish(status);
    }

    /** Call when the integration throws. Always logged while logging is enabled, whatever the level. */
    public void fail(Exception e) {
        if (completed) {
            return;
        }
        evt.Error_Message__c = truncate(e.getTypeName() + ': ' + e.getMessage(), MAX_ERROR_TEXT);
        evt.Stack_Trace__c = truncate(e.getStackTraceString(), MAX_ERROR_TEXT);
        debug('Exception: ' + e.getTypeName() + ': ' + e.getMessage());
        publish(STATUS_FAILED);
    }

    private void publish(String status) {
        if (completed) {
            return;
        }
        completed = true;
        Boolean isError = (status == STATUS_FAILED || status == STATUS_PARTIAL);
        if (!isEnabled() || (level == LEVEL_ERROR && !isError)) {
            return;
        }
        try {
            evt.Integration_Name__c = integrationName;
            evt.Status__c = status;
            evt.Log_Level__c = level;
            evt.Request_Id__c = Request.getCurrent().getRequestId();
            evt.Running_User__c = UserInfo.getUserName();
            evt.Records_Received__c = recordsReceived;
            evt.Records_Inserted__c = inserted;
            evt.Records_Updated__c = updated;
            evt.Records_Failed__c = failed;
            evt.Execution_Time_ms__c = System.currentTimeMillis() - startTime;
            evt.Limits_Summary__c = limitsSummary();
            evt.Request_Body__c = truncate(mask(requestBody), MAX_LONG_TEXT);
            evt.Response_Body__c = truncate(mask(evt.Response_Body__c), MAX_LONG_TEXT);
            if (!recordResults.isEmpty()) {
                evt.Record_Results__c = truncate(JSON.serializePretty(recordResults), MAX_LONG_TEXT);
            }
            if (!debugLines.isEmpty()) {
                evt.Debug_Log__c = truncate(String.join(debugLines, '\n'), MAX_LONG_TEXT);
            }
            Database.SaveResult sr = EventBus.publish(evt);
            if (!sr.isSuccess()) {
                System.debug(LoggingLevel.ERROR, 'IntegrationLogger could not publish log: ' + sr.getErrors());
            }
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'IntegrationLogger failed: ' + e.getMessage() + '\n' + e.getStackTraceString());
        }
    }

    /** Called by IntegrationLogEventTrigger. */
    public static void saveLogs(List<Integration_Log_Event__e> events) {
        List<Integration_Log__c> logs = new List<Integration_Log__c>();
        for (Integration_Log_Event__e e : events) {
            Integration_Log__c log = new Integration_Log__c();
            for (String f : LOG_FIELDS) {
                log.put(f, e.get(f));
            }
            logs.add(log);
        }
        for (Database.SaveResult sr : Database.insert(logs, false)) {
            if (!sr.isSuccess()) {
                System.debug(LoggingLevel.ERROR, 'Integration_Log__c insert failed: ' + sr.getErrors());
            }
        }
    }

    // ---------------------------------------------------------------------------------------------
    // Masking
    // ---------------------------------------------------------------------------------------------

    private Boolean maskingOn() {
        return setting.Mask_Sensitive_Data__c == true;
    }

    /**
     * Partially masks the values of sensitive JSON keys, e.g. "Email":"jane@x.com" -> "Email":"ja****@x.com".
     * Handles string and numeric values at any depth. If the body can't be processed it is dropped rather
     * than stored unmasked.
     */
    @TestVisible
    private String mask(String body) {
        if (String.isBlank(body) || !maskingOn()) {
            return body;
        }
        String fields = String.isBlank(setting.Sensitive_Fields__c) ? DEFAULT_SENSITIVE_FIELDS : setting.Sensitive_Fields__c;
        List<String> keys = new List<String>();
        for (String k : fields.split(',')) {
            if (String.isNotBlank(k)) {
                keys.add(Pattern.quote(k.trim()));
            }
        }
        if (keys.isEmpty()) {
            return body;
        }
        try {
            // group 2 = quoted string value, group 3 = bare number value
            Matcher m = Pattern.compile(
                '(?i)"(' + String.join(keys, '|') + ')"\\s*:\\s*(?:"((?:[^"\\\\]|\\\\.)*)"|(-?[0-9][0-9.eE+-]*))'
            ).matcher(body);
            List<String> parts = new List<String>();
            Integer last = 0;
            while (m.find()) {
                Integer g = m.group(2) != null ? 2 : 3;
                parts.add(body.substring(last, m.start(g)));
                // numbers become a masked string so the digits don't survive
                parts.add(g == 2 ? maskValue(m.group(g)) : '"' + maskValue(m.group(g)) + '"');
                last = m.end(g);
            }
            parts.add(body.substring(last));
            return String.join(parts, '');
        } catch (Exception e) {
            return '[not logged: body could not be masked - ' + e.getMessage() + ']';
        }
    }

    @TestVisible
    private static String maskValue(String value) {
        if (String.isBlank(value)) {
            return value;
        }
        Integer at = value.indexOf('@');
        if (at > 0) {
            return value.left(Math.min(2, at)) + '****' + value.substring(at);
        }
        if (value.length() <= 4) {
            return '****';
        }
        return value.left(2) + '****' + value.right(2);
    }

    // ---------------------------------------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------------------------------------

    private static Integration_Log_Setting__mdt loadSetting(String name) {
        if (settingOverride != null) {
            return settingOverride;
        }
        Integration_Log_Setting__mdt s = Integration_Log_Setting__mdt.getInstance(name);
        if (s == null) {
            s = Integration_Log_Setting__mdt.getInstance(DEFAULT_SETTING);
        }
        if (s == null) {
            // No configuration deployed: still capture failures.
            s = new Integration_Log_Setting__mdt(
                Enabled__c = true,
                Log_Level__c = LEVEL_ERROR,
                Log_Request_Body__c = true,
                Log_Response_Body__c = true,
                Mask_Sensitive_Data__c = true
            );
        }
        return s;
    }

    private static String limitsSummary() {
        return ('SOQL ' + Limits.getQueries() + '/' + Limits.getLimitQueries()
            + ', Query rows ' + Limits.getQueryRows() + '/' + Limits.getLimitQueryRows()
            + ', DML ' + Limits.getDmlStatements() + '/' + Limits.getLimitDmlStatements()
            + ', DML rows ' + Limits.getDmlRows() + '/' + Limits.getLimitDmlRows()
            + ', CPU ' + Limits.getCpuTime() + '/' + Limits.getLimitCpuTime() + ' ms'
            + ', Heap ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize()).left(255);
    }

    @TestVisible
    private static String truncate(String value, Integer maxLength) {
        if (value == null || value.length() <= maxLength) {
            return value;
        }
        return value.left(maxLength - TRUNCATED.length()) + TRUNCATED;
    }
}