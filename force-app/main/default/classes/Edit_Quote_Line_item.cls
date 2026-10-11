public class Edit_Quote_Line_item {
public string rem{get;set;}
public list<Proposal_Line_Item__c> ql{get;set;}
apttus_proposal_proposal__c qq;
string qid;
map<id,Proposal_Line_Item__c> de=new map<id,Proposal_Line_Item__c>();
    public Edit_Quote_Line_item ()
    { ql=new list<Proposal_Line_Item__c>();
    qid=apexpages.currentpage().getparameters().get('id');
    qq=[select id ,PriceList__c from apttus_proposal_proposal__c where id=:qid limit 1];
for(Proposal_Line_Item__c nn:[SELECT Id,Discount_Exception__c,Start_Date__c,Comment__c,Contract_Duration1__c, Price__c,Price_After_Discount__c,Gross_Total__c,End_Date__c, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Product__c,Product__r.Name, Adjustment_Amount__c, Adjustment_Type__c, Quantity__c, Proposal_Locked__c, Status__c,Product__r.No_Discount__c FROM Proposal_Line_Item__c WHERE Proposal_Locked__c=: qid order by createddate])
{
ql.add(nn);
de.put(nn.id,nn);
}   
    
    }    
   public pagereference save()
   {
   try{
       
        //@imRam added from here
       
       for(Proposal_Line_Item__c pp : ql){
       
   Integer numberDaysDue = pp.Start_Date__c.daysBetween(pp.End_Date__c); 
   
           system.debug('numberDaysDue ---->'+numberDaysDue);
           system.debug('Start_Date__c ---->'+pp.Start_Date__c);
           system.debug('End_Date__c ---->'+pp.End_Date__c);
           
    Integer month31 = pp.Start_Date__c.Month();
    System.debug('This is the month30---------------->'+month31);
           
    if( pp.Start_Date__c < system.today() ){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Ensure Start Date is greater or equal to today'));
    return null;
    }if(pp.End_Date__c <= pp.Start_Date__c ){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date should be greater than Start Date'));
    return null;
    }
    if(numberDaysDue > 366){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Duration cannot be greater than 12 Months'));
    return null;
    }      
     if(pp.Contract_Duration1__c == '6 Months' && numberDaysDue != 183 && pp.Product__r.Name !='Custom Sponsorship')
    {
        
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date cannot be greater/lesser than contract duration : 6 Months'));
             return null;
    }
        
    else if(pp.Contract_Duration1__c == '3 Months' && numberDaysDue != 92 && pp.Product__r.Name !='Custom Sponsorship')
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date cannot be greater/lesser than contract duration : 3 Months'));
             return null;
    }
    
   
      else if(  pp.Contract_Duration1__c == '1 Month' && numberDaysDue != 30 && pp.Product__r.Name !='Custom Sponsorship')  
         {
             System.debug('contract duration--------->'+pp.Contract_Duration1__c);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date cannot be greater/lesser than contract duration 1 Month (30 days)'));
             return null;
         }
   /*(month31 == 1 || month31 == 3 || month31 == 5 || month31 == 7 || month31 == 8 || month31 == 10 || month31 == 12) &&
    else If( (month31 == 4 || month31 == 6 || month31 == 9 || month31 == 7 || month31 == 11) && pp.Contract_Duration1__c == '1 Month' && numberDaysDue != 30)  
         {
             System.debug('contract duration--------->'+pp.Contract_Duration1__c);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Duration cannot be greater/lesser than 1 Month (30 days)'));
             return null;
         }
    else If( (month31 == 2) && (pp.Contract_Duration1__c == '1 Month' && numberDaysDue != 29) )
    {
           System.debug('contract duration--------->'+pp.Contract_Duration1__c);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Duration cannot be greater/lesser than 1 Month (29 days)'));
             return null;
         }*/
     
 }
   
   update ql;
   
   return new pagereference('/'+qid);
   }catch(exception e){
   ApexPages.addMessages(e);
   return null;
   }
   
   } 
    
    
    public pagereference check_approval()
{

return new pagereference('/apex/CustomApprovalProcessController?id='+rem);

}

 public void remove()
{
Proposal_Line_Item__c k=de.get(rem);
delete k;
ql=[SELECT Id,Discount_Exception__c, IsDeleted, Name, Price__c,Price_After_Discount__c,Gross_Total__c,End_Date__c , CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Product__c, Adjustment_Amount__c, Adjustment_Type__c, Quantity__c, Proposal_Locked__c, Status__c,Start_Date__c,Comment__c,Product__r.No_Discount__c  FROM Proposal_Line_Item__c WHERE Proposal_Locked__c=: qid];

}


public pagereference Recongif()
{
   
  update ql;

return new pagereference('/apex/reconfigure?id='+rem+'&source=Edit_Quote_Line_item');


}
}

/* set<id> pid=new set<id>();
   set<string>adtype=new set<string>();
   for(Proposal_Line_Item__c jj:ql)
   {
   pid.add(jj.product__C);
      adtype.add(jj.Adjustment_Type__c);
   
   }
   map<string,Decimal> mm=new map<string,Decimal>();
          for(Discount_Attributes__c k: [SELECT Id, Name, Product__c, Max_Value__c, Adjustment_Type__c FROM Discount_Attributes__c WHERE Product__c=:pid and Adjustment_Type__c=:adtype])
          {
          string s=k.Product__c+k.Adjustment_Type__c ;
          mm.put(s,k.Max_Value__c);
          
          }
   string userid=userinfo.getuserid();
    for(Proposal_Line_Item__c jj:ql)
   {
      string a=jj.Product__c+jj.Adjustment_Type__c;
      if(mm.get(a)!=null){
      if(jj.Adjustment_Amount__c>mm.get(a))
      {
          Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
          req1.setComments('Submitting request for approval As Discount Value is high');
        req1.setObjectId(jj.id);
        req1.setSubmitterId(userid); 

          req1.setProcessDefinitionNameOrId('quote_line');
        req1.setSkipEntryCriteria(true);
        
       try{
        Approval.ProcessResult result = Approval.process(req1);   
        }
        
        catch(Exception e)
        {
        
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Recall The product from Approval Process To edit Lineitem'));
    return null;
        
        
        }     
      
      
      }
      else
      {
      jj.status__c='Approved';
      
      }
      }else
      {
       jj.status__c='Approved';
      
      }
   
   }*/