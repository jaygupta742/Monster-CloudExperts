@isTest
public class REST_CampMem_Update_Process_Test {
    
    
    static testMethod void testconvertJsonToSobjectLst(){
        
        Test.startTest();
        
        Trigger__c t2 = new Trigger__c(name = 'Account',active__c = true);
        Trigger__c t3 = new Trigger__c(name = 'Contact',active__c = true);
        
        insert t2;
        insert t3;
        
        Profile profileId = [SELECT Id,Name FROM Profile WHERE Id='00e7F000000uSSh' limit 1];
        
        User usr = new User(LastName = 'LIVESTON',
                            FirstName='JASON',
                            Alias = 'jliv',
                            Email = 'jason.liveston@asdf.com',
                            Username = 'jason.livestonabc@asdf.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US',
                            department ='SMB Business');
        try{ 
            User u= new user(); 
            u=[select id,profileid from user where id='0057F000003Sa4K'];
            
            System.runAs(u){
                
                Account a = new Account();
                a.Name = 'ANKSkkkakka';
                a.SalesChannel__c = 'ECOMM';
                a.Import_Source__c='sssss';
                a.Lead_Source1__c='CR';
                a.Segment__c = 'ECOMM';
                a.APAC_Industry__c='Energy';
                a.No_of_Employees__c= 25;
                a.Account_Type__c='NIT';
                a.Location__c='India';
                a.Case_Accounts__c = true;
                a.Website='www.asdfert.com';
                a.Phone= '+917878787878';
                a.RegistrationNumber__c='asq111111';
                a.Lead_Account_Status__c='Inactive';
                //a.CreditStatus__c='ok';
                a.BillingStreet='street1';
                a.BillingCity='city1';
                a.BillCountry__c='INDIA';
                a.BillingState='State1';
                a.ShippingStreet='street2';
                a.ShippingCity='cty2';
                a.ShippingState='state2';
                a.ShippingPostalCode='5600182';
                a.BillingPostalCode='5600892';
                a.ShippingCountry='INDIA';
                a.OwnerId=u.id;
                
                a.Lead_Account_Status__c='Active';
                a.CreditStatus__c='OK';
                insert a;
                
                Contact c = new Contact();
                c.AccountID= a.Id;
                c.LastName='Testcontact';
                c.Email='someaddress@email.com';
                c.Phone='9999988888';
                c.Case_Contact__c = true;
                c.PrimarySalesContact__c=true;
                insert c;
                
                
                List<Leads__C> leadList= new List<Leads__C>();
                Leads__C leadLst= new Leads__C();//Lead Status First Name Last Name Company
                leadLst.Name = 'Lead Testing';
                leadlst.Company__c = 'My Company';
                
                leadList.add(leadLst);
                insert leadList;
                
                List<Campaign__c>testCmplist = new List<Campaign__c>();
                
                for(integer i=0; i<5;i++){
                    Campaign__c cmp = new Campaign__c();
                    cmp.Name = 'Test Campaign '+i;
                    cmp.Campaign_Run_Date__c = system.today();
                    testCmplist.add(cmp);
                }
                if(!testCmplist.isEmpty())
                    Insert testCmplist;
                
                
                List<Campaign_Member__c> testcmpmlist = new List<Campaign_Member__c>();
                
                for(integer j=0; j<5;j++){
                    Campaign_Member__c cmpm = new Campaign_Member__c();
                    cmpm.Contact__c = c.Id;
                    cmpm.Campaign__c = testCmplist[0].Id;
                    testcmpmlist.add(cmpm);
                }
                if(!testcmpmlist.isEmpty())
                    Insert testcmpmlist;
                
                
                // getObjApiName Method
                String obj = RESTCampMemUpdateProcess.getObjApiName(c.Id);
                system.debug('obj--> '+obj);
                
                // createFormattedDateTime Method
                RESTCampMemUpdateProcess.createFormattedDateTime('01-06-2022 23:19');
                RESTCampMemUpdateProcess.createFormattedDateTime('NULL');
                RESTCampMemUpdateProcess.createFormattedDateTime('');
                
                
                // convertJsonToSobjectLst Method
                
                RestRequest req = new RestRequest(); 
                RestResponse res = new RestResponse();             
                req.requestURI = '/services/apexrest/updateCampMem/*';
                req.httpMethod = 'POST';
                RestContext.request = req;
                String str = '[{"campaignMemberID": "'+testCmplist[0].Id+'__'+testcmpmlist[0].Id+'__'+c.Id+'", "sentDate": "07-06-2022 23:19", "bounceDate": "01-06-2022 23:19", "bounceCategory": "Soft Bounce", "openDate": "03-06-2022 23:19", "clickDate": "null", "unsubscribedDate": "03-06-2022 23:19"}]';
                req.requestBody= Blob.valueOf(str);
                RestContext.response= res;
                RESTCampMemUpdateProcess.convertJsonToSobjectLst();
            }
            
        }catch(Exception ex){
            system.debug('Exception Occured'+ex.getMessage());
        }
        Test.stopTest();
    }
}