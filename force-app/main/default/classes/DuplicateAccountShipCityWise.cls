//DuplicateAccountShipCityWise
////Test class---------------------ForAllDuplicateAccountBatchApex_Test
global class DuplicateAccountShipCityWise implements Database.Batchable<Sobject>,Database.Stateful {
    public string query;
    public String sameShipingCityFile;
    public integer count;
    public AsyncApexJob ap;
    global Database.QueryLocator start(Database.BatchableContext cc){
        string stw='Abiezer M Sdn Bhd';
       query='SELECT id,name, AccountID__c,CreatedBy.name,Phone,Old_Owner__c,owner.manager.name,Import_Source__c,Segment__c,CreatedDate,CreditStatus__c, AccountStatus__c, RegistrationNumber__c, APAC_Industry__c, Lead_Account_Status__c, Owner.name, SalesChannel__c, Lead_Source1__c, Location__c, Website, BillingCity, BillingCountry, ShippingCity, ShippingCountry FROM Account where Integration__c=false And Person_Account__c=false And Case_Accounts__c=false  Order By name ASC ' ;  
       
        return Database.getQueryLocator(query);
        
    }
    global void execute(Database.BatchableContext cc, List<Account> ac){
        
        if(count==null ){
            count=0;
        }
        Map<String, List<Account>> mp= new Map<String, List<Account>>();
        
         
         Map<String, List<Account>> mpPostCity= new Map<String, List<Account>>();
         

        
        for(Account a:ac){
          
            if(mp.containskey(a.name)){
                 List<Account> dpAc1 = mp.get(a.name);
                dpac1.add(a);
                
                mp.put(a.name,dpAc1);
                
            }else
                mp.put(a.Name,new list<Account> {a});
            
           }
        System.debug('mp ki value '+mp);
        
        Map<String, List<Account>> cityAccountMap= new Map<String, List<Account>>();
        for(string a:mp.keyset()){
        
            List<Account> acc= new List<Account>();
             acc= mp.get(a);
             
            if(acc.size()>1){
                for(Account c:acc){
                   
                    if( mpPostCity.containskey(c.ShippingCity)){
                        List<Account>  pCityList=mpPostCity.get(c.ShippingCity);
                        pCityList.add(c);
                        mpPostCity.put(c.ShippingCity ,pCityList); 
                    }
                    else if(!mpPostCity.containskey(c.ShippingCity)  ){
                         mpPostCity.put(c.ShippingCity,new list<Account> {c});
                    }
                    
                    
                  
               }
            }  
         }
        //Account_Type__c, APAC_Industry__c, Lead_Account_Status__c, Owner.name, SalesChannel__c, Lead_Source1__c, Location__c, Website,
        if(sameShipingCityFile==null ||sameShipingCityFile==''){
        sameShipingCityFile='Record ID'+','+'Account ID'+','+'Account Name'+','+'Account Owner'+','+'Old Owner'+','+'Primary Sales Manager'
                                       +','+'Credit Status'+','+'Created Date'+','+'Created Year' 
                                       +','+'Created By'+','+'Import Source' +','+'Sales Channel' 
                                       +','+'Segment' +','+'Lead Account Status' +','+'Status' +','+'Posting City (Address)' 
                                       +','+'Posting Country' +','+'Billing City (Address)' +','+'Billing Country' 
                                       +','+'Account Phone' +','+'Website'+','+'Registration No'+','+'Account Locations';
        }
      
        String st='';
        for(String a:mpPostCity.keyset()){
            
              List<Account> sameBillCity=mpPostCity.get(a);
             
             //
             if(sameBillCity.size()==2 || sameBillCity.size()>2){
                 String localRec='';
             for(Account c:sameBillCity){
           localRec=localRec+(c.id+','+c.AccountID__c+','+c.name+','+c.Owner.name+','+c.Old_Owner__c+','+c.owner.manager.name
                                  +','+c.CreditStatus__c+','+c.CreatedDate+','+(c.CreatedDate).year()+','+c.CreatedBy.name
                                  +','+c.Import_Source__c+','+c.SalesChannel__c+','+c.Segment__c+','+c.Lead_Account_Status__c
                                  +','+c.AccountStatus__c+','+c.ShippingCity+','+c.ShippingCountry +','+c.BillingCity
                                  +','+c.BillingCountry+','+c.Phone+','+c.Website+','+c.RegistrationNumber__c+','+c.Location__c+'\n');   
                  
              }
                 
          st=st+localRec;
            }
            
         }
      
         IF(ap==null){
            ap =new AsyncApexJob();
           ap=[ SELECT ID,TotalJobItems,apexclass.name FROM AsyncApexJob where apexclass.name='DuplicateAccountShipCityWise' And Status='Processing' limit 1];
        }
             sameShipingCityFile=sameShipingCityFile +'\n'+st;
             st='';
        if(Limits.getHeapSize()>11000000){
                sendEmail(sameShipingCityFile);
                    sameShipingCityFile='';
        }
         count++;
         system.debug(count+'  Here Is size  '+ap.TotalJobItems);
        if(count==ap.TotalJobItems && Limits.getHeapSize()<11000000){
            system.debug('Here Is size');
             sendEmail(sameShipingCityFile);
                    sameShipingCityFile='';
        }
        
       
            }

    global void finish(Database.BatchableContext cc){
        

        
        
        
    }
    public void sendEmail(String sp){
        Messaging.SingleEmailMessage email= new  Messaging.SingleEmailMessage();
         Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
         blob ofile = Blob.valueOf(sp);
         efa.setBody(ofile);
         efa.setFileName('ShipCityDuplicateAccount.csv');
         email.setSubject( 'subject' );
         List<String> st= new List<String>();
         st.add('crm@cloudexpertsindia.com');
         email.setToAddresses( st);
         email.setPlainTextBody( 'body' );

         email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});

        
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
    }
}