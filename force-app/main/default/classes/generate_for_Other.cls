public class generate_for_Other {
public String selectedCountry1{get;set;}
public list<Proposal_Line_Item__c> ql{get;set;}
Proposal_Line_Item__c qli;
Proposal_Line_Item__c qli1;

    public generate_for_Other()
    {
        qli=[SELECT Id, IsDeleted,Price__c,End_Date__c,Product_Name__c,APTS_Attribute_Display__c,Start_Date__c, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Product__c, Adjustment_Amount__c, Adjustment_Type__c, Quantity__c, Proposal_Locked__c, Status__c FROM Proposal_Line_Item__c WHERE id=: apexpages.currentpage().getparameters().get('id') limit 1];
        
    qli1=qli;
    qli1.id=null;
    qli1.Product_Name__c = qli.Product_Name__c;
  //  qli1.Start_Date__c=null;
  //  qli1.End_Date__c=null;
  //  qli1.Adjustment_Amount__c=null;
  //  qli1.Adjustment_Type__c=null;
    }
   
    
    
     public List<SelectOption> getCountriesOptions() {
        List<SelectOption> countryOptions = new List<SelectOption>();
        countryOptions.add(new SelectOption('1 Month','1 Month'));
        countryOptions.add(new SelectOption('3 Months','3 Months'));
        countryOptions.add(new SelectOption('6 Months','6 Months'));
        countryOptions.add(new SelectOption('12 Months','12 Months'));
        
 
        return countryOptions;
    }
    
    public pagereference Addtocart()
    {date d=qli.End_Date__c+1;
        if(selectedCountry1=='1 Month')
        {
            qli1.Start_Date__c=d;
            qli1.End_Date__c= qli1.Start_Date__c.addMonths(1);
           
        
        }else if(selectedCountry1=='3 Months')
        {
             qli1.Start_Date__c=d;
            qli1.End_Date__c=qli1.Start_Date__c.addMonths(3);
        
        
        }else if(selectedCountry1=='6 Months')
        {
             qli1.Start_Date__c=d;
            qli1.End_Date__c=qli1.Start_Date__c.addMonths(6);
        
        
        }else
        {
        
             qli1.Start_Date__c=d;
            qli1.End_Date__c=qli1.Start_Date__c.addMonths(12);
        
        }
        
      
        upsert qli1;
    
   return new pagereference('/apex/q_discount?id='+qli.Proposal_Locked__c);
    
    }


}