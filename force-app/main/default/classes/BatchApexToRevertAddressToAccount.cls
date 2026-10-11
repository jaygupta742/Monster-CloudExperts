global class BatchApexToRevertAddressToAccount implements Database.Batchable<sObject>, Database.Stateful{
	public string last_record;
	Public String Bothnull;
    Public String BAnull;
	Public String SAnull;
    Public String NBothnull;

    
   global Database.QueryLocator start(Database.BatchableContext BC){

       String query = 'select id,Accountid__c,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where (Person_Account__c = false AND Case_Accounts__c = false AND Integration__c = false AND Accountid__c>:last_record)  Order by Accountid__c ASC limit 100000';

       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Account> scope){
       Bothnull = 'ID,AccountID\n';
       BAnull = 'ID,AccountID\n';
       SAnull = 'ID,AccountID\n';
       NBothnull = 'ID,AccountID\n';
       for(Account a : scope){
           last_record = a.Accountid__c;
           
        /*   if(a.Addresses1__r.size()!=0 && a.Addresses1__r.size()==1){
               for(Address1__c ad : a.Addresses1__r){
                   if(ad.Address1__c != Null){
                       a.ShippingStreet = ad.Address1__c;
                       a.BillingStreet = ad.Address1__c;
                   }
                   if(ad.Country__c != Null){
                       a.ShippingCountry = ad.Country__c;
                       a.BillingCountry = ad.Country__c;
                   }
                   if(ad.state__c != Null){
                       a.ShippingState = ad.state__c;
                       a.BillingState = ad.state__c;
                   }
                   if(ad.City__c != Null){
                       a.ShippingCity = ad.City__c;
                       a.BillingCity = ad.City__c;
                   }
                   if(ad.PinCode__c != Null){
                       a.ShippingPostalCode = ad.PinCode__c;
                       a.BillingPostalCode = ad.PinCode__c;
                   }
               }
           }
           if(a.Addresses1__r.size()!=0 && a.Addresses1__r.size()>1){
               integer count=0;
               Boolean BA=false,SA=false;
               for(Address1__c ad : a.Addresses1__r){
   
                   count++;
                   if((ad.Type__c == 'Billing & Posting' || ad.Type__c == 'Billing & Shipping') && (BA == false && SA == false)){
                       if(ad.Address1__c != Null){
                           a.ShippingStreet = ad.Address1__c;
                           a.BillingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.ShippingCountry = ad.Country__c;
                           a.BillingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.ShippingState = ad.state__c;
                           a.BillingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.ShippingCity = ad.City__c;
                           a.BillingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.ShippingPostalCode = ad.PinCode__c;
                           a.BillingPostalCode = ad.PinCode__c;
                       }
                       BA = true;
                       SA = true;
                   }
                   if((ad.Type__c == 'Billing & Posting' || ad.Type__c == 'Billing & Shipping') && (BA == true && SA == false)){
                       if(ad.Address1__c != Null){
                           a.ShippingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.ShippingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.ShippingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.ShippingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.ShippingPostalCode = ad.PinCode__c;
                       }
                       SA = true;
                   }
                   if((ad.Type__c == 'Billing & Posting' || ad.Type__c == 'Billing & Shipping') && (BA == false && SA == true)){
                       if(ad.Address1__c != Null){
                           a.BillingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.BillingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.BillingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.BillingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.BillingPostalCode = ad.PinCode__c;
                       }
                       BA = true;
                   }
                   if((ad.Type__c == 'Billing') && (BA == false)){
                       if(ad.Address1__c != Null){
                           a.BillingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.BillingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.BillingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.BillingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.BillingPostalCode = ad.PinCode__c;
                       }
                       BA = true;
                   }
                   if((ad.Type__c == 'Posting Address' || ad.Type__c == 'Shipping') && (SA == false)){
                       if(ad.Address1__c != Null){
                           a.ShippingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.ShippingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.ShippingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.ShippingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.ShippingPostalCode = ad.PinCode__c;
                       }
                       SA = true;
                   }
                   if((a.Addresses1__r.size() == count && ad.Type__c == 'Site Address') && (SA == false && BA == false)){
                       if(a.Addresses1__r[0].Address1__c != Null){
                           a.ShippingStreet = a.Addresses1__r[0].Address1__c;
                           a.BillingStreet = a.Addresses1__r[0].Address1__c;
                       }
                       if(a.Addresses1__r[0].Country__c != Null){
                           a.ShippingCountry = a.Addresses1__r[0].Country__c;
                           a.BillingCountry = a.Addresses1__r[0].Country__c;
                       }
                       if(a.Addresses1__r[0].state__c != Null){
                           a.ShippingState = a.Addresses1__r[0].state__c;
                           a.BillingState = a.Addresses1__r[0].state__c;
                       }
                       if(a.Addresses1__r[0].City__c != Null){
                           a.ShippingCity = a.Addresses1__r[0].City__c;
                           a.BillingCity = a.Addresses1__r[0].City__c;
                       }
                       if(a.Addresses1__r[0].PinCode__c != Null){
                           a.ShippingPostalCode = a.Addresses1__r[0].PinCode__c;
                           a.BillingPostalCode = a.Addresses1__r[0].PinCode__c;
                       }
                       BA = true;
                       SA = true;
                   }
                   if((a.Addresses1__r.size() == count && ad.Type__c == 'Site Address' ) && (SA == false)){
                       if(a.Addresses1__r[0].Address1__c != Null){
                           a.ShippingStreet = a.Addresses1__r[0].Address1__c;
                       }
                       if(a.Addresses1__r[0].Country__c != Null){
                           a.ShippingCountry = a.Addresses1__r[0].Country__c;
                       }
                       if(a.Addresses1__r[0].state__c != Null){
                           a.ShippingState = a.Addresses1__r[0].state__c;
                       }
                       if(a.Addresses1__r[0].City__c != Null){
                           a.ShippingCity = a.Addresses1__r[0].City__c;
                       }
                       if(a.Addresses1__r[0].PinCode__c != Null){
                           a.ShippingPostalCode = a.Addresses1__r[0].PinCode__c;
                       }
                       SA = true;
                   }
                   if((a.Addresses1__r.size() == count && ad.Type__c == 'Site Address' ) && (BA == false)){
                       if(a.Addresses1__r[0].Address1__c != Null){
                           a.BillingStreet = a.Addresses1__r[0].Address1__c;
                       }
                       if(a.Addresses1__r[0].Country__c != Null){
                           a.BillingCountry = a.Addresses1__r[0].Country__c;
                       }
                       if(a.Addresses1__r[0].state__c != Null){
                           a.BillingState = a.Addresses1__r[0].state__c;
                       }
                       if(a.Addresses1__r[0].City__c != Null){
                           a.BillingCity = a.Addresses1__r[0].City__c;
                       }
                       if(a.Addresses1__r[0].PinCode__c != Null){
                           a.BillingPostalCode = a.Addresses1__r[0].PinCode__c;
                       }
                       BA = true;
                   }
                   if((a.Addresses1__r.size() == count && ad.Type__c != 'Site Address' ) && (SA == false && BA == false)){
                       if(ad.Address1__c != Null){
                           a.ShippingStreet = ad.Address1__c;
                           a.BillingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.ShippingCountry = ad.Country__c;
                           a.BillingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.ShippingState = ad.state__c;
                           a.BillingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.ShippingCity = ad.City__c;
                           a.BillingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.ShippingPostalCode = ad.PinCode__c;
                           a.BillingPostalCode = ad.PinCode__c;
                       }
                       BA = true;
                       SA = true;
                   }
                   if((a.Addresses1__r.size() == count && ad.Type__c != 'Site Address' ) && (SA == false)){
                       if(ad.Address1__c != Null){
                           a.ShippingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.ShippingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.ShippingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.ShippingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.ShippingPostalCode = ad.PinCode__c;
                       }
                       SA = true;
                   }
                   if((a.Addresses1__r.size() == count && ad.Type__c != 'Site Address' ) && (BA == false)){
                       if(ad.Address1__c != Null){
                           a.BillingStreet = ad.Address1__c;
                       }
                       if(ad.Country__c != Null){
                           a.BillingCountry = ad.Country__c;
                       }
                       if(ad.state__c != Null){
                           a.BillingState = ad.state__c;
                       }
                       if(ad.City__c != Null){
                           a.BillingCity = ad.City__c;
                       }
                       if(ad.PinCode__c != Null){
                           a.BillingPostalCode = ad.PinCode__c;
                       }
                       BA = true;
                   }
               }
               if(BA == false && SA == false)
                   Bothnull = Bothnull + a.id+','+a.AccountID__c+'\n';
               if(BA == false)
                   BAnull = BAnull + a.id+','+a.AccountID__c+'\n';
               if(SA == false)
                   SAnull = SAnull + a.id+','+a.AccountID__c+'\n';
           }
           else {
                   NBothnull = NBothnull + a.id+','+a.AccountID__c+'\n';
           }*/
       }
       database.update(scope,false);
   }

global void finish(Database.BatchableContext BC){
  
    
    Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
    String[] toAddresses = new list<string> {'support@cloudexpertsindia.com','crm@cloudexpertsindia.com'};
    String subject ='Address To Account  CSV '+last_record;
    email.setSubject(subject);
    email.setToAddresses( toAddresses );
    email.setPlainTextBody('Account CSV '+last_record);
    
    	Blob bn = blob.valueOf(Bothnull);
    	Messaging.EmailFileAttachment bnefa = new Messaging.EmailFileAttachment();
        bnefa.setFileName('BothNull.csv');
        bnefa.setBody(bn);
    	Blob san = blob.valueOf(SAnull);
    	Messaging.EmailFileAttachment sanefa = new Messaging.EmailFileAttachment();
        sanefa.setFileName('SANull.csv');
        sanefa.setBody(san);
    	Blob ban = blob.valueOf(BAnull);
    	Messaging.EmailFileAttachment banefa = new Messaging.EmailFileAttachment();
        banefa.setFileName('BANull.csv');
        banefa.setBody(ban);
    	Blob nbn = blob.valueOf(Bothnull);
    	Messaging.EmailFileAttachment nbnefa = new Messaging.EmailFileAttachment();
        nbnefa.setFileName('NoBothNull.csv');
        nbnefa.setBody(nbn);
    	List<Messaging.EmailFileAttachment> lefa = new List<Messaging.EmailFileAttachment>();
    	lefa.add(bnefa);
        lefa.add(sanefa);
        lefa.add(banefa);
    	lefa.add(nbnefa);
    	
        email.setFileAttachments(lefa);
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
   } 
}