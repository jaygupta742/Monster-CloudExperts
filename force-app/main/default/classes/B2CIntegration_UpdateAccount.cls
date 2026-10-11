@RestResource(urlMapping='/UpdateAccount')
global class B2CIntegration_UpdateAccount {
    @HttpPost
    global static String doPost(String accountId, String dispositions, String pitched) {
        Map<String, Object> mapResponse = new Map<String, Object> (); 
        try {
            Account acc = [SELECT Id, Name, Dispositions__c, Pitched__c FROM Account WHERE Id =: accountId];
            acc.Dispositions__c = dispositions;
            acc.Pitched__c = pitched;
            update acc;
            mapResponse.put('Status', 'Success');
            mapResponse.put('Message', 'Account updated successfully.');
        } catch(Exception e) {
            mapResponse.put('Status', 'Error');
            mapResponse.put('Message', e.getMessage());
        }
        
        return JSON.serialize(mapResponse);
    } 
}