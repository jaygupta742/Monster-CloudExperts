/*Last Modifeid By : Abdul Aziz
* Last Modifed Date : 5-apr-2023
* Restricted team member insertion on creating new account or updating owner of exusting account*/

public class AccountTriggerHandler {
    public AccountTriggerHandler(){
        
    }
    
    private static List<User> salesReps;
    
    public void OnBeforeInsert(Account[] newObjects){
        // EXECUTE BEFORE INSERT LOGIC
        
        // Trigger AccountTradename
        for(Account a:newObjects){
            a.Trade_name__c = a.Name;
            
            // @ rj to update custom bil country and state and post country adn state to standard 
            if(a.BillCountry__c != null  ){
                a.BillingCountry = a.BillCountry__c;
            }
            if(a.BillState__c != null)
            {
                a.BillingState = a.BillState__c;
            }
            
            if(a.PostCountry__c != null){
                a.ShippingCountry = a.PostCountry__c;
            }
            if(a.PostState__c != null){
                a.ShippingState = a.PostState__c;
            }  
        } 
        
        system.debug('ROund Robin Working 123');
        
        Integer currentIndex = getCurrentIndex();
        Boolean updateCurrentIndexBoolen = false;
        
        try{
            for(Account accountRecord:newObjects){
                if(accountRecord.Page_URL__c == null && salesReps.size() >= 1) continue;
                if(accountRecord.Page_URL__c.contains('certificate') || accountRecord.Page_URL__c.contains('certification') && accountRecord.Integration__c == true){                
                    if(salesReps == null) loadSalesReps();
                    accountRecord.OwnerId = salesReps[currentIndex].Id;
                    currentIndex = Math.mod((currentIndex + 1), salesReps.size());
                    updateCurrentIndexBoolen = true;
                }
            } 
            
            if(updateCurrentIndexBoolen) updateCurrentIndex(currentIndex);
        }catch(Exception e){
            system.debug(e.getLineNumber());
        }
    }
    
    private static void loadSalesReps() {
        salesReps = [SELECT Id, LastLoginDate FROM User WHERE Profile.Name IN ('Monster - Seeker Certification Sales') AND IsActive = TRUE];
        
        if (salesReps.isEmpty()) {
            System.debug('No active sales reps found.');
        } else {
            System.debug('Active Sales Reps Loaded: ' + salesReps.size());
        }
    }
    
    private static Integer getCurrentIndex() {
        Integer currentIndex = 0;
        RoundRobinSettings__c settings;

        try {
            settings = [SELECT Id, LastAssignedUserIndex__c FROM RoundRobinSettings__c LIMIT 1];
            System.debug('RoundRobinSettings found: ' + settings);
            currentIndex = settings.LastAssignedUserIndex__c != null ? Integer.valueOf(settings.LastAssignedUserIndex__c) : 0;
        } catch (QueryException e) {
            System.debug('Error fetching RoundRobinSettings: ' + e.getMessage());
            return currentIndex;
        }
        
        return currentIndex;
    }
    
    
    private static void updateCurrentIndex(Integer currentIndex) {
        RoundRobinSettings__c settings;
        
        try {
            settings = [SELECT Id, LastAssignedUserIndex__c FROM RoundRobinSettings__c LIMIT 1];
        } catch (QueryException e) {
            settings = new RoundRobinSettings__c();
            settings.Name = 'Default';
            System.debug('No RoundRobinSettings found, creating a new one.');
        }
        
        settings.LastAssignedUserIndex__c = currentIndex;
        System.debug('Upserting RoundRobinSettings with LastAssignedUserIndex__c: ' + currentIndex);
        upsert settings;
    }
    
    
    
    /* public void BeforeUpdate(Account[] newObjects)
{
for(Account a1 : newObjects)
{



}
}*/
    
    public void OnAfterInsert(Account[] newObjects){
        // EXECUTE AFTER INSERT LOGIC
        
        // Process Builder - Account Owner to Account Team Members
        List<Account_Team_Member__c> atm = new List<Account_Team_Member__c>();
        for(account a: newObjects){
            Account_Team_Member__c at = new Account_Team_Member__c();
            at.AccountId__c = a.id;
            at.Sales_Channel__c = a.SalesChannel__c;
            at.Segment__c = a.Segment__c;
            at.UserId__c = a.ownerid;
            atm.add(at);
        }
        // insert atm;
        //   system.debug('Account Team Members after insert--->'+atm); 
        
    }
    
    public void OnBeforeUpdate(Account[] oldObjects, Account[] updatedObjects,Map<ID, Account> NewObjectMap, Map<ID, Account> OldObjectMap){
        // BEFORE UPDATE LOGIC
        // Trigger AccountTradename 
        set<id> aid = new set<id>(); //AccountStatus  Trigger
        //set<id> OldAcc = new set<id>(); 
        Map<String, Account> OldMapAcc= new Map<String,Account>();
        
        for(Account ac:oldObjects){
            OldMapAcc.put(ac.id,ac ) ;
        }
        
        
        for(Account na :updatedObjects){
            //Added By Pawan Soni 
            Account oldAcTds=OldMapAcc.get(na.id);
            if(na.TDS_Credit_Status__c!=oldAcTds.TDS_Credit_Status__c)
            {
                na.TDS_Credit_Status_Hold_By__c= userinfo.getName();
                na.TDS_Credit_Status_Hold_Date__c=System.Today();
            }
            
            
            
            // @ rj to update custom bil country and state and post country adn state to standard 
            if(na.BillCountry__c != null  ){
                na.BillingCountry = na.BillCountry__c;
            }
            if(na.BillState__c != null)
            {
                na.BillingState = na.BillState__c;
            }
            if(na.PostCountry__c != null){
                na.ShippingCountry = na.PostCountry__c;
            }
            if(na.PostState__c != null){
                na.ShippingState = na.PostState__c;
            } 
            if(na.BillState__c == null){
                na.BillingState =''; 
            }
            
            
            Account oa = OldObjectMap.get(na.id);
            
            
            if((na.Name != oa.Name && oa.Name == oa.Trade_name__c) || (na.Trade_name__c == null || na.Trade_name__c == '')){
                na.Trade_name__c = na.Name;
            }
            
            // below code is AccountStatus  Trigger
            aid.add(na.Id);   // adding id's to the set
            if(na.AccountStatus__c == 'Active'){
                na.Lead__c = False;
            }
            
            account oldAcc =  OldObjectMap.get(na.id);
            string autoMat = na.Owner_History__c;
            system.debug('autoMat-->'+autoMat);
            system.debug('OwnerId-->'+na.OwnerId);
            
            boolean OwneridAlreadyThere = false;
            
            
            if(oldAcc.OwnerId != na.OwnerId){
                
                if(autoMat != NULL)
                    OwneridAlreadyThere = autoMat.containsIgnoreCase(oldAcc.OwnerId);
                
                system.debug('OwneridAlreadyThere-->'+OwneridAlreadyThere);
                if(OwneridAlreadyThere == false){
                    if(na.Owner_History__c == NULL){
                        na.Owner_History__c = oldAcc.ownerid;
                    }else{na.Owner_History__c = na.Owner_History__c + ';' + oldAcc.ownerid;}
                }
            }           
            
        }
        
        list<contact> con = new list<contact>([SELECT id,name FROM contact WHERE accountid =:aid ]);
        
        // list<Address1__c> add = new list<Address1__c>([SELECT id , name FROM Address1__c WHERE Account__c =:aid]); //To change Address from Object to Standard Address in Account
        
        user u = new user();
        u = [Select id,name,ta__c from user where id=: UserInfo.getUserId()];
        for(Account a : updatedObjects){
            
            if((con.size()<=0 || con.size() == NULL ) && a.Lead_Account_Status__c == 'Active' && a.Integration__c == false && u.TA__c == false){
                //|| add.size()<=0 || add.size() == NULL removed by @imRam
                
                a.adderror('Please create Contact to update the status to Active');
            }           
        } 
        
    }
    
    public void OnAfterUpdate(Account[] oldObjects, Account[] updatedObjects, Map<ID, Account> NewObjectMap , Map<ID, Account> OldObjectMap){
        // AFTER UPDATE
        set<id> aid = new set<id>();
        
        List<Account_Team_Member__c> atm = new List<Account_Team_Member__c>();
        
        for(account a :updatedObjects){
            aid.add(a.id);
        }
        
        list<account> NewAcc = [SELECT id,name,ownerid,SalesChannel__c,Segment__c,owner.name,Owner_History__c,(SELECT id,name,ownerid,owner.name,Owner_History__c FROM Orders__r),(SELECT id,name,ownerid,owner.name,Owner_History__c  FROM Opportunities__r),(SELECT id,name,ownerid,owner.name,Owner_History__c  FROM Quotes_Proposals2__r) FROM Account WHERE id =:aid];
        system.debug('Account details in trigger --> '+NewAcc);
        
        /*  map<string,OrderC__share> MapOrder = new map<string,OrderC__share>();
list<OrderC__share> ExtOrder = [SELECT id,AccessLevel,ParentId,UserOrGroupId FROM OrderC__share WHERE ParentId =:aid];
for(OrderC__share oo :ExtOrder ){
MapOrder.put(oo.ParentId,oo);
}system.debug('OrderC__share -->'+MapOrder);*/
        
        /*   map<string,apttus_proposal_proposal__share> MapQuote = new map<string,apttus_proposal_proposal__share>();
list<apttus_proposal_proposal__share> ExtQuote = [SELECT id,AccessLevel,ParentId,UserOrGroupId FROM apttus_proposal_proposal__share WHERE ParentId =:aid];
for(apttus_proposal_proposal__share oo :ExtQuote ){
MapQuote.put(oo.ParentId,oo);
}system.debug('apttus_proposal_proposal__share -->'+MapQuote);*/
        
        //If owner is already changed
        /*   map<string,Opportunity__share> MapOpportunity = new map<string,Opportunity__share>();
list<Opportunity__share> ExtOpportunity = [SELECT id,AccessLevel,ParentId,UserOrGroupId FROM Opportunity__share WHERE ParentId =:aid];
for(Opportunity__share oo :ExtOpportunity ){
MapOpportunity.put(oo.ParentId,oo);
}system.debug('Opportunity__share -->'+MapOpportunity);


system.debug('OrderC__share -->'+ExtOrder);
system.debug('apttus_proposal_proposal__share -->'+ExtQuote);
system.debug('Opportunity__share -->'+ExtOpportunity);  */
        
        
        list<OrderC__share> ShareOrder = new list<OrderC__share>();
        list<apttus_proposal_proposal__share> ShareQuote = new list<apttus_proposal_proposal__share>();
        list<Opportunity__share> ShareOpportunity = new list<Opportunity__share>();
        
        
        list<OrderC__c> UpdateOrder = new list<OrderC__c>();
        list<apttus_proposal_proposal__c> UpdateQuote = new list<apttus_proposal_proposal__c>();
        list<Opportunity__c> UpdateOpportunity = new list<Opportunity__c>();
        
        for(account a:NewAcc){
            
            account oldAcc =  OldObjectMap.get(a.id);
            
            
            
            if(oldAcc.OwnerId != a.OwnerId){
                
                Account_Team_Member__c at = new Account_Team_Member__c();
                at.AccountId__c = a.id;
                at.Sales_Channel__c = a.SalesChannel__c;
                at.Segment__c = a.Segment__c;
                at.UserId__c = a.ownerid;
                //  atm.add(at);
                
                
                
                //account related opportunity
                integer oppsize = a.Opportunities__r.size();
                system.debug('oppsize--->'+oppsize);
                if(a.Opportunities__r.size() != NULL || a.Opportunities__r.size() >0)
                    for(Opportunity__c o : a.Opportunities__r){
                        //If opportunity previously not shared
                        if(a.OwnerId != o.ownerid){
                            Opportunity__share os = new Opportunity__share();
                            os.AccessLevel = 'Read';
                            os.ParentId =o.id;
                            os.UserOrGroupId = a.ownerid;
                            ShareOpportunity.add(os);
                            
                            
                            UpdateOpportunity.add(o);
                        }
                    }
                
                
                
                //account related quote
                integer qotsize = a.Quotes_Proposals2__r.size();
                system.debug('qotsize--->'+qotsize);
                if(a.Quotes_Proposals2__r.size() != NULL || a.Quotes_Proposals2__r.size()>0)
                    for(apttus_proposal_proposal__c ap : a.Quotes_Proposals2__r){
                        //If Quote previously not shared
                        if(a.OwnerId != ap.ownerid){
                            apttus_proposal_proposal__share os = new apttus_proposal_proposal__share();
                            os.AccessLevel = 'Read';
                            os.ParentId =ap.id;
                            os.UserOrGroupId = a.ownerid;
                            ShareQuote.add(os);
                            
                            
                            UpdateQuote.add(ap);
                        }
                    }
                
                
                
                //account related order
                integer ordsize = a.Orders__r.size();
                system.debug('ordsize--->'+ordsize); 
                if(a.Orders__r.size() != NULL || a.Orders__r.size() >0)
                    for(OrderC__c ord : a.Orders__r){
                        
                        //If Order owner not the changed account owner
                        if(a.OwnerId != ord.ownerid){
                            
                            OrderC__share os = new OrderC__share();
                            os.AccessLevel = 'Read';
                            os.ParentId =ord.id;
                            os.UserOrGroupId = a.ownerid;
                            ShareOrder.add(os);
                            
                            UpdateOrder.add(ord);
                        }
                    }
                
            } //if owner comparision closed
            
            
        } //for account loop closed
        
        // insert ShareOpportunity;
        insert ShareQuote;
        insert ShareOrder;
        insert ShareOpportunity;
        
        /* database.update(UpdateOpportunity,false);
database.update(UpdateQuote,false);
database.update(UpdateOrder,false);*/
        
        //   insert atm;
        //  system.debug('Account Team Members after update--->'+atm);
    }
    
    public void OnBeforeDelete(Account[] ObjectsToDelete,Map<ID, Account> MapObjectMap){
        // BEFORE DELETE LOGIC
    }
    
    public void OnAfterDelete(Account[] deletedObjects,Map<ID, Account> MapObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(Account[] restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    
    
}