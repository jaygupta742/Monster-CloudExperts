global class validationChange {
	webservice static void userchange(List<string> cvr,String uid){
        List<Client_Validation_Request__c> lc = new List<Client_Validation_Request__c>();
        for(String ac : cvr){
            Client_Validation_Request__c c = new Client_Validation_Request__c();
            c.id = ac;
            c.Validation_Owner__c = uid;
            lc.add(c);
        }
        update lc;
    }
}