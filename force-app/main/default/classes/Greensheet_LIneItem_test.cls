@istest 
public class Greensheet_LIneItem_test
    {

        public static testmethod void my_test()
        {
        Green_Sheet__c h=new Green_Sheet__c();
        insert h;
         PageReference pageRef = Page.Greensheet_LIneItem;
        Test.setCurrentPage(pageRef);
         ApexPages.currentPage().getParameters().put('cc', h.id);
         
         Greensheet_LIneItem g=new Greensheet_LIneItem();
         g.addrow();
         g.numberOfRowToRemove=1;
         g.removeNewObject();
         g.save();
         g.cancel();
        
        
        // for edit all page
        Contract_Line_Item__c jk=new Contract_Line_Item__c();
        jk.Green_Sheet__c=h.id;
          PageReference pageRef1 = Page.Editall;
        Test.setCurrentPage(pageRef1);
         ApexPages.currentPage().getParameters().put('cc', h.id);
         editall kk=new editall();
         kk.save();
         kk.cancel();
        
        }








    }