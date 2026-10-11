global class GCS_Opportunity {
    webservice static string Methodpa(string ids) {
        Account ac = [select id, name from Account where id=:ids];
        //Address1__c addr =[SELECT id,name FROM Address1__c WHERE Account__c =:ac.id LIMIT 1];
        Xcode_Account__c xcod = [SELECT id,name,Xcode__r.id FROM Xcode_Account__c WHERE Account__c=:ac.id AND Is_Primary__c = True LIMIT 1];
        contact con = [SELECT id,name FROM Contact WHERE Accountid =: ac.id AND PrimarySalesContact__c = True LIMIT 1];
        user u = new user();
        u= [SELECT id,name,Price_List__c FROM USER WHERE id=:UserInfo.getUserId()];
        Product_PriceList__c pp =[SELECT id,name FROM Product_PriceList__c WHERE name =: u.Price_List__c];
       String rt = Schema.SObjectType.Opportunity__c.getRecordTypeInfosByName().get('Monster').getRecordTypeId();
       //String rt1 = Schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('before_finalize').getRecordTypeId();
            Opportunity__c op = new Opportunity__c();
            op.Account__c=ac.id;
            op.Name__c='New GCS Opp -' + ac.name;
            op.Close_Date__c=System.today().addMonths(1);
            op.OpportunityType__c='Ecomm New';
            op.Stage__c='Identification';
            op.OpportunitySource__c = 'Ecomm New';
            op.RecordTypeId=rt;
            op.GCS_Opps__c=true;
            op.Amount__c=00.00;
            op.Xcode__c=xcod.Xcode__r.id;
             insert op;
            
             
            apttus_proposal_proposal__c app = new apttus_proposal_proposal__c();
            app.Account__c = ac.id;
            app.Opportunity__c=op.id;
            app.APTS_Quote_Type__c='Ecomm New';
            app.Order_Type__c='Ecomm New';
            app.Channel__c ='Ecomm New';
            app.PriceList__c =pp.id;
            app.Primary_Contact__c=con.id;
            app.Selling_Country__c='India';
            app.BillContact__c=con.id;
            app.PostingContact__c=con.id;
            app.Billing_Address__c = 'Account Billing Address';
            app.Posting_Address__c = 'Account Posting Address';
            //app.Billing_Address__c=addr.id;
           // app.Posting_Address__c=addr.id;
            app.Xcode__c=xcod.Xcode__r.id;
            //app.RecordTypeId = rt1;
            insert app;
            return app.id;
    }  
    
    @AuraEnabled
    Public static String checkForError(id recordId){
        List<Xcode_Account__c> xacc = new List<Xcode_Account__c>();
        xacc = [SELECT id,name,Xcode__r.id,Account__r.Lead_Account_Status__c FROM Xcode_Account__c WHERE Account__c =: recordId AND Is_Primary__c = True LIMIT 1];
        System.debug('Xacc '+xacc);
        
        if(xacc.size()<=0){
            return 'Please make sure the Xcode Account you have added is Primary and then try again';
        }
        else if(xacc[0].Account__r.Lead_Account_Status__c != 'Active'){
            return 'Account should be active to proceed';
        }
        List<Contact> con = new List<Contact>();
        con = [SELECT id,name FROM Contact WHERE Accountid =: recordId AND PrimarySalesContact__c = True LIMIT 1];
        if(con.size()<=0){
            return 'Please make sure the Contact You have is Primary sales contact and then try again';
        }
        USER user = new USER();
        user = [SELECT id,name,Price_List__c FROM USER WHERE id =: userinfo.getUserId()];
        List<Product_PriceList__c> prodPriceList = new List<Product_PriceList__c>();
        prodPriceList = [SELECT id,name FROM Product_PriceList__c WHERE name =:user.Price_List__c LIMIT 1];
        if(user.Price_List__c == null || prodPriceList.size()<=0){
            return 'Something went wrong on user price list please contact system admin/raise ticket on tracker object';
        }
        String rt = Schema.SObjectType.Opportunity__c.getRecordTypeInfosByName().get('Monster').getRecordTypeId();
            Opportunity__c op = new Opportunity__c();
            op.Account__c=recordId;
            //op.Name__c='New GCS Opp -' + ac.name;
            op.Close_Date__c=System.today().addMonths(1);
            op.OpportunityType__c='Ecomm New';
            op.Stage__c='Identification';
            op.OpportunitySource__c = 'Ecomm New';
            op.RecordTypeId=rt;
            op.GCS_Opps__c=true;
            op.Amount__c=00.00;
            op.Xcode__c=xacc[0].Xcode__r.id;
            insert op;
            
             
            apttus_proposal_proposal__c app = new apttus_proposal_proposal__c();
            app.Account__c = recordId;
            app.Opportunity__c=op.id;
            app.APTS_Quote_Type__c='Ecomm New';
            app.Order_Type__c='Ecomm New';
            app.Channel__c ='Ecomm New';
            app.PriceList__c =prodPriceList[0].id;
            app.Primary_Contact__c=con[0].id;
            app.Selling_Country__c='India';
            app.BillContact__c=con[0].id;
            app.PostingContact__c=con[0].id;
            app.Billing_Address__c = 'Account Billing Address';
            app.Posting_Address__c = 'Account Posting Address';
            //app.Billing_Address__c=addr.id;
           // app.Posting_Address__c=addr.id;
            app.Xcode__c=xacc[0].Xcode__r.id;
            //app.RecordTypeId = rt1;
            insert app;
            return 'Success '+app.id;
    }

}