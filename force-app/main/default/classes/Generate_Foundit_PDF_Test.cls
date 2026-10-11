/*Created by : Abdul Aziz , Created Date : 08/07/2023 , Test class for Generate_Foundit_PDF */
@isTest(SeeAllData=true)
public class Generate_Foundit_PDF_Test {
    public @istest static void TestMethod01() {
        QuotesN__c EQuote = [SELECT Id, Name, Approval_Status_Overall__c FROM QuotesN__c WHERE Approval_Status_Overall__c =: 'Approved' LIMIT 1];
        Test.startTest();
        PageReference pageRef = Page.GeneratePdf;  
        Test.setCurrentPage(pageRef); 
        ApexPages.currentPage().getParameters().put('id', EQuote.id ); 
        ApexPages.StandardController sc = new ApexPages.standardController(EQuote);
        
        Generate_Foundit_PDF controller =new Generate_Foundit_PDF(sc); 
        controller.getItems();
        controller.gettype();
        controller.pagename = 'name';
        
        controller.settype('name');
        controller.selectcon();
        controller.pdfdoc_val='HK Addendum Report-Apttus';
        
        controller.UpadteOpp();
        try {
            controller.Generate();
        }
        catch(Exception e) {
        }
        
        Foundit_Quote_Pdf__c p1 = new Foundit_Quote_Pdf__c();
        p1.Name='FoundIt_IN_STD';
        p1.Location__c='India';
        p1.Pdf__c='FoundIt_IN_STD';
        insert p1;
        
        List<Generate_Foundit_PDF.wrap> www=new List<Generate_Foundit_PDF.wrap>();
        Generate_Foundit_PDF.wrap w1=new Generate_Foundit_PDF.wrap(p1);
        
        Test.stopTest();
    }
}