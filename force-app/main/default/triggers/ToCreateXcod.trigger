trigger ToCreateXcod on Xcode__c (After Insert) {

    set<id> aid = new set<id>();
    set<id> xid = new set<id>();
    
    for(Xcode__c x:trigger.new){
    aid.add(x.Created_For_Account__c);
    xid.add(x.id);
    
    }
    
    list<Xcode_Account__c> xco1 = new list<Xcode_Account__c>([SELECT id,name,Account__c,Xcode__c FROM Xcode_Account__c WHERE Account__c=:aid AND Xcode__c !=:xid]);
    list<Xcode_Account__c> xco = new list<Xcode_Account__c>(); 
    system.debug('ssssssssss'+xco1.size());
    
    for(Xcode__c a :trigger.new)
    {
      Xcode_Account__c acc=new Xcode_Account__c();
     
      acc.Account__c = a.Created_For_Account__c;
      acc.Xcode__c=a.id;
      
      if(xco1.size() == 0){
      system.debug('aaaaaaaaaaaa');
      acc.Is_Primary__c =true;
      }
      
      xco.add(acc);
    }
    insert xco;
 
}