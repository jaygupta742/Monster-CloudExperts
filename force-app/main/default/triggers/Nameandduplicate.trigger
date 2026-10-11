trigger Nameandduplicate on Target__c (before insert,before update) {
    set<string> targetunique = new set<String>();
    set<id> uids = new set<id>();
    Map<id,String> username = new Map<id,String>();
    List<User> allusers = new List<user>([select id,Name from User]);
    for(user u : allusers ){
        username.put(u.id, u.Name);
    }
    for(Target__c t : trigger.new){
        t.Name = username.get(t.User__c) +'-'+t.Start_Date__c.format() +'-'+ t.End_Date__c.format();
        targetunique.add(t.Name);
        uids.add(t.User__c);
        t.OwnerId = t.User__c;
    }
    List<Target__c> lt = new List<Target__c>([select Name,id,User__r.Name,Start_date__c,End_Date__c from Target__c where user__c = :uids]);
    	String sBreak = '</br>'; 
        String first = '<a href="'; 
        String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();  
        String last = '" target="_blank">check the target here.</a>';
    for(Target__c t : trigger.new){
        for(Target__c t1 : lt){
        	t.Name = username.get(t.User__c) +'-'+t.Start_Date__c.format() +'-'+ t.End_Date__c.format();
            if(t.User__c == t1.User__c)
            if(((t.Start_Date__c >= t1.Start_Date__c && t.Start_Date__c <= t1.End_Date__c) || (t.End_Date__c >= t1.Start_Date__c && t.End_Date__c <= t1.End_Date__c) || (t.Start_Date__c <= t1.Start_Date__c && t.End_Date__c >= t1.End_Date__c)) && (t.id != t1.id)){
                t.addError('Target for '+t1.User__r.Name +' user within the date range is already created '+ sBreak + first + fullFileURL + '/' + t1.id + last,false);
            }
        }
    }
}