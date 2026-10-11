@isTest
public class Generate_Price_Test {
   @isTest Static void Generate_Price_Test()
   {   ProductM__c p = new ProductM__c();
        p.name ='Job Postings';
        insert p;
    
       Product_PriceList__c pp = new Product_PriceList__c();
       pp.Name = 'ABC';
       insert pp;
    
       Product_Price_Entry__c ppe = new Product_Price_Entry__c();
       ppe.PriceList__c=pp.id;
       ppe.Product__c = p.id;
       insert ppe;
    
       Gencode__c g = new Gencode__c();
       g.Attribute_1__c= 'Hong Kong';
       g.Attribute_2__c='National';
       g.Attribute_3__c='Hong Kong';
       g.Attribute_4__c= 'Standard';
       g.Attribute_5__c= 'Standard'; 
       g.Attribute_6__c='60 Days';
       g.Attribute_7__c='Hong Kong';
       g.Attribute_8__c= 'Standard';
       g.Attribute_9__c= 'Standard';
       g.Product__c= p.id;
       g.Product_PriceList__c= pp.id;
    
    Insert g;
   
    Generate_Price.gencode();
    Generate_Price.gencode1(p.id);
   }
}