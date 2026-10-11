@RestResource(urlMapping = '/MonsterCleverTapIntegration/')
global class MonsterCleverTapIntegration{
    
    global static Boolean runTrigger = true;
    global static Map<Id,User> userMap = new Map<Id,User>();
    global static Map<Id,User> userMapToBeUpdated = new Map<Id,User>();
    
    @HttpPost
    global static String doPost(){
        // Logging is configured in Setup > Custom Metadata Types > Integration Log Setting > MonsterCleverTapIntegration
        IntegrationLogger logger = new IntegrationLogger('MonsterCleverTapIntegration');
        logger.logRequest(RestContext.request);
        try {
            String result = processRequest(logger);
            logger.finish(result);
            return result;
        } catch (Exception e) {
            logger.fail(e);
            throw e;
        }
    }
    
    private static String processRequest(IntegrationLogger logger){
        
        RestRequest req = RestContext.request;
        String jsonBody = req.requestBody.toString();
        
// Deserialize new request body 
		CleverTapRequest requestBody = (CleverTapRequest) JSON.deserialize(jsonBody, CleverTapRequest.class); 
        if (requestBody == null || requestBody.profiles == null || requestBody.profiles.isEmpty()) { return 'No profiles found'; } 
        List<MonsterWrapper> bodyList = requestBody.profiles;
        logger.setRecordsReceived(bodyList.size());
        
        Set<String> emailSet = new Set<String>();
        Set<String> stateSet = new Set<String>();
        
        for (MonsterWrapper w : bodyList){
            if (String.isNotBlank(w.Email))
                emailSet.add(w.Email);
            
            if (String.isNotBlank(w.state))
                stateSet.add(w.state.toLowerCase());
        }
        
        Map<String, Account> existingAccountMap = new Map<String, Account>();
        if (!emailSet.isEmpty()){
            for (Account acc : [
                SELECT Id, Email__c, CreatedDate, Last_Activity_Created_Date__c
                FROM Account
                WHERE Email__c IN :emailSet
            ]){
                existingAccountMap.put(acc.Email__c, acc);
            }
        }
        
        RecordType rt = [
            SELECT Id FROM RecordType
            WHERE DeveloperName = 'Person_Account'
            LIMIT 1
        ];
        
        // 🔒 Lock members
        List<Lead_Assignment_Members__c> members = [
            SELECT Id, Name, State_Selection__c,
            Years_Of_Experience__c,
            User__c
            FROM Lead_Assignment_Members__c
            WHERE State_Selection__c != null
            AND User__r.isActive = true
        ];
        
        // 🔒 Lock logs
        List<Lead_Assignment_State_Log__c> stateLogs = [
            SELECT Id, Assignment_Key__c,
            Lead_Assignment_Member__c,
            State__c,
            Last_Assigned_Time__c
            FROM Lead_Assignment_State_Log__c
            WHERE State__c IN :stateSet
        ];
        
        userMap = new Map<Id,User>([SELECT Id,Account_Count__c FROM User WHERE isActive = true]);
        logger.debug('Existing accounts matched: ' + existingAccountMap.size() + ', assignment members: ' + members.size()
                     + ', state logs: ' + stateLogs.size() + ', active users: ' + userMap.size());
        
        Map<String, Map<Id, Lead_Assignment_State_Log__c>> stateLogMap =
            new Map<String, Map<Id, Lead_Assignment_State_Log__c>>();
        
        for (Lead_Assignment_State_Log__c log : stateLogs){
            String s = log.State__c.toLowerCase();
            
            if (!stateLogMap.containsKey(s))
                stateLogMap.put(s, new Map<Id, Lead_Assignment_State_Log__c>());
            
            stateLogMap.get(s).put(log.Lead_Assignment_Member__c, log);
        }
        
        Map<String, Lead_Assignment_State_Log__c> logsToUpsertMap =
            new Map<String, Lead_Assignment_State_Log__c>();
        
        Map<String,Account> accountsToInsert = new Map<String,Account>();
        Map<String,Account> accountsToUpdate = new Map<String,Account>();
        Set<String> processedEmails = new Set<String>();
        
        Map<Id, Lead_Assignment_Members__c> mapOfleadAssignmentMembers = new  Map<Id, Lead_Assignment_Members__c>();
        
        for (MonsterWrapper w : bodyList){
            Account acc = new Account();
            acc.Seeker_ID__c = w.seekerid;
            acc.First_Name__c = w.fname;
            acc.Last_Name__c = w.lname;
            acc.Email__c = w.Email;
            acc.city__c = w.city;
            acc.Institute_Name__c = w.instituteName;
            acc.Program_Name__c = w.programName;
            acc.Alternate_Email__c = w.alt_email;
            acc.Phone = w.primary_phone;
            acc.Mobile__c = w.mobile;
            acc.Location__c = w.CurrentLocation;
            acc.Experience__c = w.Experience;
            acc.Categories__c = w.Categories;
            acc.Resume__c = w.Resume;
            acc.APAC_Industry__c = w.Industry;
            acc.Role__c = w.Roles;
            acc.ResumeID__c = w.ResId;
            acc.Salary__c = w.Salary;
            acc.Registration_Date__c = w.Registration;
            acc.Update_Date__c = w.Updatedate;
            acc.Nationality__c = w.Nationality;
            acc.PA_Address__c = w.Address;
            acc.PA_Country__c = w.Country;
            acc.Source_File__c = w.Source_File;
            acc.Name = w.fname + ' ' + w.lname;
            acc.Integration__c = true;
            acc.Person_Account__c = true;
            acc.RecordTypeId = rt.Id;
            acc.Lead_Source1__c = 'Clever Tap';
            acc.Lead_Score__c = w.leadscore;
            acc.Team__c = w.team;
            acc.Last_Owner_Update__c = System.today();
            acc.Highest_Education__c = w.highest_education;
            acc.Passing_Year__c = w.passing_year;
            acc.Company_Name__c = w.company_name;
            acc.Page_URL__c = w.pageUrl;
            acc.Page_Name__c = w.pageName;
            acc.State_N__c = w.state;
            
            if(w.pageview != null){
                if(w.pageview.length() <= 255){
                    acc.Page_View__c = w.pageview;
                }
            }
            
            acc.cart__c = w.cart;
            acc.Salary_Range__c = w.salary_range;
            acc.UTM_Campaign__c  = w.utm_campaign;
            acc.UTM_Content__c  = w.utmContent;
            acc.UTM_Source__c  = w.utm_Source;
            acc.UTM_Medium__c = w.utm_medium;
            acc.UTM_Term__c  = w.utmTerm;
            acc.Preferred_specialisation__c  = w.pref_specialization;
            acc.Work_Experience__c = w.exp_range;
            
            system.debug(w.pageVisitedUrl);
            
            if(!String.isBlank(w.pageVisitedUrl) && w.pageVisitedUrl != null){
                acc.Page_Visited_Url__c = w.pageVisitedUrl;
            }
            
            Lead_Assignment_Members__c assignedMember =
                assignLead(w.state, members, stateLogMap, logsToUpsertMap);
            
            Boolean allowReassign = true;
            
            if (existingAccountMap.containsKey(w.Email)){
                
                Account oldAcc = existingAccountMap.get(w.Email);
                acc.Id = oldAcc.Id;
                
                Date createdPlus7 = oldAcc.CreatedDate.date().addDays(7);
                
                // Case 1: Activity exists
                if (oldAcc.Last_Activity_Created_Date__c != null){
                    
                    if (oldAcc.Last_Activity_Created_Date__c <= createdPlus7){
                        allowReassign = false;
                    }
                    
                }
                // Case 2: No activity → check CreatedDate + 7
                else {
                    
                    if (Date.today() <= createdPlus7){
                        allowReassign = false;
                    }
                    
                }
            }
            
            
            logger.debug('seekerid=' + w.seekerid + ', state=' + w.state + ', existing=' + (acc.Id != null)
                         + ', assignedMember=' + (assignedMember == null ? null : assignedMember.Id) + ', allowReassign=' + allowReassign);
            
            runTrigger = false;
            
            if (assignedMember != null && allowReassign){
                mapOfleadAssignmentMembers.put(assignedMember.Id, assignedMember);
                acc.Lead_Assignment_Member__c = assignedMember.Id;
                acc.OwnerId = assignedMember.User__c;
                acc.AssignmentReason__c = 'STATE_USER';
                
                userMap.put(assignedMember.User__c,updateUserCount(userMap,assignedMember.User__c));
            }
            
            if (existingAccountMap.containsKey(w.Email)){
                if (accountsToUpdate.containsKey(acc.Email__c)){
                    preserveNonBlankFields(acc, accountsToUpdate.get(acc.Email__c));
                }
                accountsToUpdate.put(acc.Email__c,acc);
            } else {
                if (accountsToInsert.containsKey(acc.Email__c)){
                    preserveNonBlankFields(acc, accountsToInsert.get(acc.Email__c));
                }
                accountsToInsert.put(acc.Email__c,acc);
            }
        }
        
        logger.debug('Accounts to insert: ' + accountsToInsert.size() + ', to update: ' + accountsToUpdate.size()
                     + ', assignment state logs to upsert: ' + logsToUpsertMap.size());
        
        List<ResponseWrapper> responseList = new List<ResponseWrapper>();
        
        if ( !accountsToInsert.values().isEmpty() ){
            Database.SaveResult[] insertResults = Database.insert (accountsToInsert.values(), false);
            
            for ( Integer i = 0; i < insertResults.size(); i++ ){
                Account acc = accountsToInsert.values()[i];
                logger.recordResult(acc.Email__c, IntegrationLogger.ACTION_INSERT, insertResults[i]);
                if ( insertResults[i].isSuccess() ){
                    responseList.add(new ResponseWrapper(acc.Email__c, 'Lead inserted successfully and assigned', mapOfleadAssignmentMembers.get(acc.Lead_Assignment_Member__c)));
                } else{
                    system.debug(insertResults[i].getErrors()[0].getMessage());
                    responseList.add(new ResponseWrapper(acc.Email__c, 'Lead failed: ' + insertResults[i].getErrors()[0].getMessage()));
                }
            }
        }
        
        if ( !accountsToUpdate.values().isEmpty() ){
            Database.SaveResult[] updateResults = Database.update (accountsToUpdate.values(), false);
            
            for ( Integer i = 0; i < updateResults.size(); i++ ){
                Account acc = accountsToUpdate.values()[i];
                logger.recordResult(acc.Email__c, IntegrationLogger.ACTION_UPDATE, updateResults[i]);
                if ( updateResults[i].isSuccess() ){
                    responseList.add(new ResponseWrapper(acc.Email__c, 'Lead updated successfully and is currently assigned', mapOfleadAssignmentMembers.get(acc.Lead_Assignment_Member__c)));
                } else{
                    system.debug(updateResults[i].getErrors()[0].getMessage());
                    responseList.add(new ResponseWrapper(acc.Email__c, 'Lead update failed: ' + updateResults[i].getErrors()[0].getMessage()));
                }
            }
        }
        
        updateUsers();
        
        if (!logsToUpsertMap.isEmpty())
            upsert logsToUpsertMap.values() Assignment_Key__c;
        
        return 'Success';
    }
    
    @future
    public static void updateUsers(){
        Database.update(userMap.values(),false);
        
    }
    
    
    public static User updateUserCount(Map<Id, User> userRecordMap, String userId) {
        User userRecord = new User();
        
        if (userRecordMap.containsKey(userId)) {
            userRecord = userRecordMap.get(userId);
            
            userRecord.Account_Count__c = (userRecord.Account_Count__c == null) ? 1 : userRecord.Account_Count__c + 1;
        }
        
        return userRecord;
    }
    
    public static Lead_Assignment_Members__c assignLead(
        String state,
        List<Lead_Assignment_Members__c> members,
        Map<String, Map<Id, Lead_Assignment_State_Log__c>> stateLogMap,
        Map<String, Lead_Assignment_State_Log__c> logsToUpsertMap){
            
            if (String.isBlank(state))
                return null;
            
            state = state.toLowerCase();
            
            List<Lead_Assignment_Members__c> eligible =
                new List<Lead_Assignment_Members__c>();
            
            for (Lead_Assignment_Members__c m : members){
                if (m.State_Selection__c != null &&
                    m.State_Selection__c.toLowerCase().contains(state))
                    eligible.add(m);
            }
            
            if (eligible.isEmpty())
                return null;
            
            eligible.sort(new ExperienceComparator());
            
            if (!stateLogMap.containsKey(state))
                stateLogMap.put(state, new Map<Id, Lead_Assignment_State_Log__c>());
            
            Map<Id, Lead_Assignment_State_Log__c> memberLogs =
                stateLogMap.get(state);
            
            Integer assignedCount = 0;
            
            for (Lead_Assignment_Members__c m : eligible){
                if (memberLogs.containsKey(m.Id) &&
                    memberLogs.get(m.Id).Last_Assigned_Time__c != null)
                    assignedCount++;
            }
            
            if (assignedCount == eligible.size()){
                for (Lead_Assignment_State_Log__c log : memberLogs.values()){
                    log.Last_Assigned_Time__c = null;
                    logsToUpsertMap.put(log.Assignment_Key__c, log);
                }
            }
            
            for (Lead_Assignment_Members__c m : eligible){
                
                if (!memberLogs.containsKey(m.Id) ||
                    memberLogs.get(m.Id).Last_Assigned_Time__c == null){
                        
                        String key = m.Id + '-' + state;
                        
                        Lead_Assignment_State_Log__c log =
                            memberLogs.containsKey(m.Id)
                            ? memberLogs.get(m.Id)
                            : new Lead_Assignment_State_Log__c(
                                Assignment_Key__c = key,
                                Lead_Assignment_Member__c = m.Id,
                                State__c = state
                            );
                        
                        log.Last_Assigned_Time__c = System.now();
                        
                        logsToUpsertMap.put(key, log);
                        memberLogs.put(m.Id, log);
                        
                        return m;
                    }
            }
            
            return null;
        }
    
    public class ExperienceComparator
        implements Comparator<Lead_Assignment_Members__c>{
            
            public Integer compare(
                Lead_Assignment_Members__c a,
                Lead_Assignment_Members__c b){
                    
                    Decimal expA = a.Years_Of_Experience__c == null ? 0 : a.Years_Of_Experience__c;
                    Decimal expB = b.Years_Of_Experience__c == null ? 0 : b.Years_Of_Experience__c;
                    
                    if (expA == expB) return 0;
                    
                    return expA > expB ? -1 : 1;
                }
        }
    
    global class CleverTapRequest { 
        public Boolean is_test; 
        public Integer targetId;  
        public List<MonsterWrapper> profiles; 
    }
    
    global class MonsterWrapper{
        public String seekerid;
        public String fname;
        public String lname;
        public String Email;
        public String alt_email;
        public String primary_phone;
        public String mobile;
        public String CurrentLocation;
        public String Experience;
        public String Categories;
        public String Resume;
        public String Industry;
        public String Roles;
        public String ResId;
        public String Salary;
        public Datetime Registration;
        public Datetime Updatedate;
        public String Nationality;
        public String Address;
        public String Country;
        public String Source_File;
        public String attchname;
        public String leadsource;
        public String leadscore;
        public String team;
        public String highest_education;
        public String passing_year;
        public String company_name;
        public String pageName;
        public String pageUrl;
        public String programName;
        public String instituteName;
        public String city;
        public String state;
        public String pageview;
        public String cart;
        public String cart_product;
        public String salary_range;
        public String utm_campaign;
        public String utm_source; 
        public String utm_medium; 
        public String utmTerm;
        public String utmContent;
        public String pageVisitedUrl;
        public String exp_range;
        public String pref_specialization;
    }
    
    global class ResponseWrapper{
        public String emailId;
        public String message;
        public Lead_Assignment_Members__c assigneeDetails;
        public ResponseWrapper(String emailId, String message, Lead_Assignment_Members__c assigneeDetails){
            this.emailId = emailId;
            this.message = message;
            this.assigneeDetails = assigneeDetails;
        }
        
        public ResponseWrapper(String emailId, String message){
            this.emailId = emailId;
            this.message = message;
            this.assigneeDetails = null;
        }
        
    }
    
    private static final List<String> FIELDS_TO_PRESERVE = new List<String>{
        'Page_Visited_Url__c',
            'UTM_Campaign__c',
            'UTM_Content__c',
            'UTM_Source__c',
            'UTM_Medium__c',
            'UTM_Term__c',
            'Foundit_Potential__c',
            'Work_Experience__c'
            };
                
                private static void preserveNonBlankFields(Account newAcc, Account prevAcc){
                    for (String fieldName : FIELDS_TO_PRESERVE){
                        String newVal = (String) newAcc.get(fieldName);
                        if (String.isBlank(newVal)){
                            String prevVal = (String) prevAcc.get(fieldName);
                            if (!String.isBlank(prevVal)){
                                newAcc.put(fieldName, prevVal);
                            }
                        }
                    }
                }
}