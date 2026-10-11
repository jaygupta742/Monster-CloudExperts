global class AccountFieldCountScheduler implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        Map<String, Integer> fieldCounts = new Map<String, Integer>();
        
        // Get all fields dynamically for Account object
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
        
        // Construct the dynamic query to select all fields
        String queryFields = String.join(new List<String>(fieldMap.keySet()), ',');
        String query = 'SELECT ' + queryFields + ' FROM Account';
        
        // Execute the query
        try {
            List<Account> accounts = Database.query(query);
            // Loop through each field
            for(String fieldName : fieldMap.keySet()) {
                Integer count = 0;
                for (Account acc : accounts) {
                    Object fieldValue = acc.get(fieldName);
                    if (fieldValue != null && String.valueOf(fieldValue).trim() != '') {
                        count++;
                    }
                }
                // Fetch field label
                String fieldLabel = fieldMap.get(fieldName).getDescribe().getLabel();
                fieldCounts.put(fieldLabel, count);
            }
            
            // Send email with the field counts
            sendEmail(fieldCounts);
        } catch (Exception e) {
            // Handle any exceptions
        }
    }
    
    private void sendEmail(Map<String, Integer> fieldCounts) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'azizabdul7383@gmail.com'}; // Add your email address here
        mail.setToAddresses(toAddresses);
        mail.setSubject('Account Field Counts');
        
        String body = 'Field Counts:\n';
        for(String fieldLabel : fieldCounts.keySet()) {
            body += fieldLabel + ': ' + fieldCounts.get(fieldLabel) + '\n';
        }
        mail.setPlainTextBody(body);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}