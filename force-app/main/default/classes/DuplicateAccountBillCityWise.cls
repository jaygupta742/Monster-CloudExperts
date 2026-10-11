global class DuplicateAccountBillCityWise implements Database.Batchable<Sobject>,Database.Stateful {
    public string query;
    public String sameBillCityFile;
    public integer count;
    public AsyncApexJob ap;
    global Database.QueryLocator start(Database.BatchableContext cc){
        string stw='Abiezer M Sdn Bhd';
       query='SELECT id,name, AccountID__c,Phone, AccountStatus__c, RegistrationNumber__c, Account_Type__c, APAC_Industry__c, Lead_Account_Status__c, Owner.name, SalesChannel__c, Lead_Source1__c, Location__c, Website, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet FROM Account where Integration__c=false And Person_Account__c=false And Case_Accounts__c=false  Order By name ASC' ;  
       
        return Database.getQueryLocator(query);
        
    }
    global void execute(Database.BatchableContext cc, List<Account> ac){
        
        if(count==null ){
            count=0;
        }
        Map<String, List<Account>> mp= new Map<String, List<Account>>();
        
         Map<String, List<Account>> mpBillCity= new Map<String, List<Account>>();
         Map<String, List<Account>> mpPostCity= new Map<String, List<Account>>();
         Map<String, List<Account>> mpBillCountry= new Map<String, List<Account>>();
         Map<String, List<Account>> mpPostCountry= new Map<String, List<Account>>();
         Map<String, List<Account>> mpLocation= new Map<String, List<Account>>();
         Map<String, List<Account>> mpPhone= new Map<String, List<Account>>();
         Map<String, List<Account>> mpwebsite= new Map<String, List<Account>>();
         Map<String, List<Account>> mpRegistration = new Map<String, List<Account>>();

        
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
                    
                    if(mpBillCity.containskey(c.BillingCity) ){
                      List<Account>  bCityList=mpBillCity.get(c.BillingCity);
                        bCityList.add(c);
                        mpBillCity.put(c.BillingCity ,bCityList);
                      }
                    else if(!mpBillCity.containskey(c.BillingCity)  ){
                        mpBillCity.put(c.BillingCity,new list<Account> {c});
                        }
                    
                    /*
                    if( mpPostCity.containskey(c.ShippingCity)){
                        List<Account>  pCityList=mpBillCity.get(c.ShippingCity);
                        pCityList.add(c);
                        mpPostCity.put(c.ShippingCity ,pCityList); 
                    }
                    else{
                         mpPostCity.put(c.ShippingCity,new list<Account> {c});
                    }
                    
                    
                    if( mpBillCountry.containskey(c.BillingCountry)){
                        List<Account>bCountryList= mpBillCountry.get(c.BillingCountry);
                        bCountryList.add(c);
                        mpBillCountry.put(c.BillingCountry ,bCountryList); 
                    }
                    else{
                         mpBillCountry.put(c.BillingCountry,new list<Account> {c});
                     }
                    
                    
                    if( mpPostCountry.containskey(c.ShippingCountry)){
                        List<Account>pCountryList=mpPostCountry.get(c.ShippingCountry);
                        pCountryList.add(c);
                        mpPostCountry.put(c.ShippingCountry ,pCountryList); 
                      }
                       else
                           {
                           mpPostCountry.put(c.ShippingCountry,new list<Account> {c}); 
                           }
                    
                    
                    if( mpLocation.containskey(c.Location__c)){
                        List<Account> locationList=mpLocation.get(c.Location__c);
                        locationList.add(c);
                        mpLocation.put(c.Location__c,locationList); 
                        }
                    else
                       {
                        mpLocation.put(c.Location__c,new list<Account> {c}); 
                       }
                    
                    
                    if( mpPhone.containskey(c.phone)){
                         List<Account> phoneList=mpPhone.get(c.phone);
                         phoneList.add(c);
                         mpPhone.put(c.Phone,phoneList);                    
                    }
                    else{
                         mpPhone.put(c.phone,new list<Account> {c}); 
                        }
                    
                  
                    if(  mpwebsite.containskey(c.Website)){
                         List<Account> websiteList=mpwebsite.get(c.Website);
                         websiteList.add(c);
                         mpwebsite.put(c.Website,websiteList); 
                         }
                    else{
                         mpwebsite.put(c.Website,new list<Account> {c}); 
                        }
                   
                    if(mpRegistration.containskey(c.RegistrationNumber__c)){
                         List<Account> registrationList=mpRegistration.get(c.RegistrationNumber__c);
                         registrationList.add(c); 
                         mpRegistration.put(c.RegistrationNumber__c,registrationList);
                    }
                     else
                     {
                          mpRegistration.put(c.RegistrationNumber__c,new list<Account> {c}); 
                     }*/
               }
            }  
         }
        //Account_Type__c, APAC_Industry__c, Lead_Account_Status__c, Owner.name, SalesChannel__c, Lead_Source1__c, Location__c, Website,
        if(sameBillCityFile==null ||sameBillCityFile==''){
        sameBillCityFile='Record ID'+','+'Account ID'+','+'Account Name'+','+'Billing Street'+','+'Billing City'+','+'Billing State'+','
                                   +'Billing Country'+','+'Billing Pincode'+','+'Account Status'+','+'Account Type'
                                   +','+'APAC Industry'+','+'Lead Account Status'+','+'Owner Name'+','+'Sales Channel'
                                   +','+'Location'+','+'Website'+'\n' ;
        }
      
        String st='';
        for(String a:mpBillCity.keyset()){
            
              List<Account> sameBillCity=mpBillCity.get(a);
             
             //
             if(sameBillCity.size()==2 || sameBillCity.size()>2){
                 String localRec='';
             for(Account c:sameBillCity){
            localRec=localRec+c.id+','+c.AccountID__c+','+c.name+','+c.BillingStreet+','+c.BillingCity+','+c.BillingState
                                             +','+c.BillingCountry+','+c.BillingPostalCode+','+c.AccountStatus__c+','
                                             +c.Account_Type__c+','+c.APAC_Industry__c+','+c.Lead_Account_Status__c+','+c.Owner.name
                                             +','+c.SalesChannel__c+','+c.Location__c+','+c.Website+'\n';    
              }
                 
          st=st+localRec;
            }
            
         }
      
         IF(ap==null){
            ap =new AsyncApexJob();
           ap=[ SELECT ID,TotalJobItems,apexclass.name FROM AsyncApexJob where apexclass.name='DuplicateAccountBillCityWise' And Status='Processing' limit 1];
        }
             sameBillCityFile=sameBillCityFile +'\n'+st;
             st='';
        if(Limits.getHeapSize()>11000000){
                sendEmail(sameBillCityFile);
                    sameBillCityFile='';
        }
         count++;
         system.debug(count+'  Here Is size  '+ap.TotalJobItems);
        if(count==ap.TotalJobItems && Limits.getHeapSize()<11000000){
            system.debug('Here Is size');
             sendEmail(sameBillCityFile);
                    sameBillCityFile='';
        }
        
       
            }

    global void finish(Database.BatchableContext cc){
        

        
        
        
    }
    public void sendEmail(String sp){
        Messaging.SingleEmailMessage email= new  Messaging.SingleEmailMessage();
         Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
         blob ofile = Blob.valueOf(sp);
         efa.setBody(ofile);
         efa.setFileName('BillCityDuplicateAccount.csv');
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