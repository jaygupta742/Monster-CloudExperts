public class q_discount {
public string rem{get;set;}
public list<Proposal_Line_Item__c> ql{get;set;}
public list<wrapp> wlist{get;set;}
public apttus_proposal_proposal__c qq{get;set;}
public apttus_proposal_proposal__c qstat;
public integer numberOfRowToRemove{get;set;}
string qid;
public boolean TCP{get;set;}
public boolean b1{get;set;}
public boolean b2{get;set;}
public Id RajprofileId; //ram added
public Id CurrentUserId;//ram added
map<id,Proposal_Line_Item__c> de=new map<id,Proposal_Line_Item__c>();
public string s1{get;set;}
 /////////////////////////////////////////////////////////////////////////////controller /////////////////////////////////////////////////////////////////////////////////////////   
 public q_discount()
   {  
       wlist=new list<wrapp>();
       ql=new list<Proposal_Line_Item__c>();
       qid=apexpages.currentpage().getparameters().get('id');
       s1 =apexpages.currentpage().getparameters().get('att');
       System.debug('This is s1---------------------->'+s1);
       qq=[select id,ownerid ,Approval_Status__c,Level_of_Approval__c,PriceList__c,Net_Total__c from apttus_proposal_proposal__c where id=:qid limit 1];
       if(qq.Approval_Status__c=='Required Approval')
       {
           b2=true;
        }
       for(Proposal_Line_Item__c nn:[SELECT Id,Price_After_Discount__c,Comment__c,Proposal_Locked__r.Total_Discount__c,Free_Trail__c,
                                     Product__r.Trail_Custom_or_Promo__c,Product__r.No_Discount__c ,Base_Total__c,Total_Discount__c  ,
                                     Price__c,Gross_Total__c , IsDeleted,End_Date__c,Start_Date__c, Name, CreatedDate, CreatedById, 
                                     LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, 
                                     Product__c,Product__r.Name,Adjustment_Amount__c, Adjustment_Type__c, Quantity__c, Proposal_Locked__c, Status__c,Contract_Duration1__c
                                     FROM Proposal_Line_Item__c WHERE Proposal_Locked__c=: qid order by createddate])
                    {
                       wlist.add(new wrapp(nn));
					  ql.add(nn);
                      de.put(nn.id,nn);
                     }   
    
    //@imRam adding
    RajprofileId = [SELECT Id FROM Profile WHERE name ='Monster - Service/CR'].Id;
    CurrentUserId = userinfo.getProfileId();
system.debug('RajprofileId--->'+RajprofileId);
system.debug('CurrentUserId--->'+CurrentUserId);
   
    }
     
    public apttus_proposal_proposal__c getqstat()
     {
         apttus_proposal_proposal__c qs = new apttus_proposal_proposal__c();
         qs=[select id,ownerid ,Approval_Status__c,Level_of_Approval__c,PriceList__c,Net_Total__c from apttus_proposal_proposal__c where id=:qid limit 1];
            if(qs.Approval_Status__c=='Required Approval')
            {
            b2=true;
            }
            else { b2 = false; }
          return qs;
     }
////////////////////////////////////////////////////////////////////////////////save method///////////////////////////////////////////////////////////////////////////////////////    
public pagereference save()
{  

   list<Proposal_Line_Item__c> list_to_update=new list<Proposal_Line_Item__c>();
   for(wrapp j:wlist)
   {
   list_to_update.add(j.ql);
   }

  try{
  update list_to_update;
  wlist=new list<wrapp>();
   for(Proposal_Line_Item__c nn:[SELECT Id,Free_Trail__c,Product__r.Trail_Custom_or_Promo__c,
                                 Product__r.No_Discount__c,Comment__c,Price_After_Discount__c,Proposal_Locked__r.Total_Discount__c,
                                 Total_Discount__c,Base_Total__c ,Price__c,Gross_Total__c , IsDeleted,End_Date__c,Start_Date__c, Name, 
                                 CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, 
                                 LastViewedDate, LastReferencedDate, Product__c, Adjustment_Amount__c, Adjustment_Type__c, Quantity__c, 
                                 Proposal_Locked__c,Product__r.Name, Status__c,Contract_Duration1__c FROM Proposal_Line_Item__c WHERE Proposal_Locked__c=: qid order by createddate])
         {
             wlist.add(new wrapp(nn));
         } 
    qq=[select id ,ownerid ,Approval_Status__c,Net_Total__c,Level_of_Approval__c,PriceList__c from apttus_proposal_proposal__c where id=:qid limit 1];
    if(qq.Approval_Status__c=='Required Approval')
    {
    b2=true;
    }
    else
    {
    b2=false;
    }
   return null;
       }
    catch(exception e)
    {
           apexpages.addMessages(e);
                return null;
    }
} 
    
/////////////////////////////////////////////////////////////////////////////////////Addnew method//////////////////////////////////////////////////////////////////////////////////////    
public pagereference Addnew()
{
try{
list<Proposal_Line_Item__c  > gg=new list<Proposal_Line_Item__c >();
    for(wrapp h:wlist)
    {
    //@imRam added from here
    //@yam added from here 
   Integer numberDaysDue = h.ql.Start_Date__c.daysBetween(h.ql.End_Date__c);
   Integer month31 = h.ql.Start_Date__c.Month();
        System.debug('This is the month31 ------------------->'+month31);
          
           system.debug('numberDaysDue ---->'+numberDaysDue);
           system.debug('Start_Date__c ---->'+h.ql.Start_Date__c);
           system.debug('End_Date__c ---->'+h.ql.End_Date__c);
          
            
      if(CurrentUserId  != RajprofileId) 
      {  //if User is not belongs to CR Team start date cannot be less than today  
      
              if( h.ql.Start_Date__c < system.today() )
              {
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Ensure Start Date is greater or equal to today'));
              return null;
              }
    
       }
       else{ //if User belongs to CR Team start date cannot be less than 15 days from today
    
            date Prevdate =  system.today() - 15;
            system.debug('Prevdate--->'+Prevdate);
    
    /*if( h.ql.Start_Date__c < Prevdate ){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Ensure Start Date is not less than 15 Days from today'));
    return null;
    }*/
    
    }
    
    /*if(h.ql.End_Date__c <= h.ql.Start_Date__c ){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date should be greater than Start Date'));
    return null;
    }*/

    if(numberDaysDue > 366)
    {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Duration cannot be greater than 12 Months'));
    return null;
    } //added @yam
    if(h.ql.Contract_Duration1__c == '6 Months' && numberDaysDue != 183 && h.ql.Product__r.Name !='Custom Sponsorship')    {
        
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration : 6 Months'));
             return null;
    }
        
    else if(h.ql.Contract_Duration1__c == '3 Months' && numberDaysDue != 92 && h.ql.Product__r.Name !='Custom Sponsorship' )
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration :  3 Months'));
             return null;
    }
     else if( h.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 30 && h.ql.Product__r.Name !='Custom Sponsorship')
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration : 1 Months(30 days)'));
             return null;
    }
        
     else if( h.ql.Contract_Duration1__c == '2 Months' && numberDaysDue != 61 )
    {
        If((h.ql.Product__r.Name !='Custom Sponsorship')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration : 2 Months(61 days)'));
             return null;
        }
    }
     /*else if( (month31 == 4 || month31 == 6 || month31 == 9 || month31 == 11)  && h.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 30 ) 
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration 1 Months(30 days)'));
             return null;
    }
       
     else If( (month31 == 2) && (h.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 29) )
    {
           System.debug('contract duration--------->'+h.ql.Contract_Duration1__c);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration 1 Month (29 days)'));
             return null;
         }*/
    gg.add(h.ql);
  }
   update gg;
   return new pagereference('/apex/Add_product1?pbid='+qq.PriceList__c+'&qid='+qid);
    } //end of try block
    
 catch(exception e){
   apexpages.addMessages(e);
    return null;
}

} //end of addnew method
////////////////////////////////////////////////////////////////////////////////remove method/////////////////////////////////////////////////////////
public void remove()
{
    wlist.remove(numberOfRowToRemove);
    Proposal_Line_Item__c k=de.get(rem);
    delete k;
}
//////////////////////////////////////////////////////////////////wrapp class/////////////////////////////////////////////////////////////////////////////
public class wrapp
{
    public boolean b{set;get;}
    public  Proposal_Line_Item__c ql{get;set;}
    
    public wrapp(Proposal_Line_Item__c g)
    {
    ql=g;
    
    }
    
    
    }
    
//////////////////////////////////////////////////////////generate for other month///////////////////////////////////////////////////////////////////////////    
 public pagereference generate_for_other_month()
 {
    string ids; integer cont = 0;
    list<Proposal_Line_Item__c  > gg=new list<Proposal_Line_Item__c >();
    for(wrapp h:wlist)
    {
    
            //@imRam added from here
            Integer numberDaysDue = h.ql.Start_Date__c.daysBetween(h.ql.End_Date__c); 
            system.debug('numberDaysDue ---->'+numberDaysDue);
           system.debug('Start_Date__c ---->'+h.ql.Start_Date__c);
           system.debug('End_Date__c ---->'+h.ql.End_Date__c);
   Integer month31 = h.ql.Start_Date__c.Month();
        System.debug('This is the month31 ------------------->'+month31);
        
          
    
     if(CurrentUserId  != RajprofileId) 
     {  //if User is not belongs to CR Team start date cannot be less than today  
    
         if( h.ql.Start_Date__c < system.today() ){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Ensure Start Date is greater or equal to today'));
         return null;
         }
    
    }
     else
     { //if User belongs to CR Team start date cannot be less than 15 days from today  
    
    date Prevdate =  system.today() - 15;
    system.debug('Prevdate--->'+Prevdate);
    
    if( h.ql.Start_Date__c < Prevdate )
    {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Ensure Start Date is not less than 15 Days from today'));
    return null;
    }
    
    } //close of else
    
    if(h.ql.End_Date__c <= h.ql.Start_Date__c ){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date should be greater than Start Date'));
    return null;
    }
    if(numberDaysDue > 366){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Duration cannot be greater than 12 Months'));
    return null;
    }
    //@ImYam adding
    if(h.ql.Contract_Duration1__c == '6 Months' && numberDaysDue != 183 &&  h.ql.Product__r.Name !='Custom Sponsorship'  )
    {
        
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration : 6 Months'));
             return null;
    }
        
    else if(h.ql.Contract_Duration1__c == '3 Months' && numberDaysDue != 92 && h.ql.Product__r.Name !='Custom Sponsorship')
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration : 3 Months'));
             return null;
    }
    else if(h.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 30 && h.ql.Product__r.Name !='Custom Sponsorship' )
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration :1 Months(30 days)'));
             return null;
    }
        //Yam added
        else if( h.ql.Contract_Duration1__c == '2 Months' && numberDaysDue != 61 )
    {
        If((h.ql.Product__r.Name !='Custom Sponsorship')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration : 2 Months(61 days)'));
             return null;
        }
    }
        
        // @yam added (month31 == 1 || month31 == 3 || month31 == 5 || month31 == 7 || month31 == 8 || month31 == 10 || month31 == 12)
    /* else if( (month31 == 4 || month31 == 6 || month31 == 9 || month31 == 11)  && h.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 30 ) 
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration 1 Months(30 days)'));
             return null;
    }
       
     else If( (month31 == 2) && (h.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 29) )
    {
           System.debug('contract duration--------->'+h.ql.Contract_Duration1__c);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration 1 Month (29 days)'));
             return null;
         }  */
   //till here
   
     
    gg.add(h.ql);

    if(h.b==true)
        {
            cont++; //@imRam added
            ids=h.ql.id;
        }
    }
    
   // modified by @imRam on 13/6/2018
   system.debug('cont value----->'+cont);
    if(cont == 0){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select the Product'));
    return null;
    }else if(cont > 1){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select only 1 Product'));
    return null;
    }else{
    update gg;
    return new pagereference('/apex/generate_for_Other?id='+ids);}
    }
///////////////////////////////////////////////////////////////////////go method///////////////////////////////////////////////////////////////////////////////
  
  public pagereference go()
    {
    
    try{
     list<Proposal_Line_Item__c> list_to_update=new list<Proposal_Line_Item__c>();
   
   for(wrapp j:wlist)
   {
   //@imRam added from here
   
  Integer numberDaysDue = j.ql.Start_Date__c.daysBetween(j.ql.End_Date__c); 
    Integer month31 = j.ql.Start_Date__c.Month();
    System.debug('This is the month30---------------->'+month31);
  //Integer numberDaysDue1 = j.ql.Start_Date__c.MonthsBetween(j.ql.End_Date__c);
  /*Date firstDate = j.ql.Start_Date__c;
  Date secondDate = j.ql.End_Date__c;
  Integer monthsBetween = firstDate.monthsBetween(secondDate);
  System.debug('This is monthsbetween'+  ' ' +monthsBetween);
   
   string s1 = string.valueOf(monthsBetween);
   System.debug('This is s1'+  ' ' +s1); //till here
    string s3 =' ';
    string s4=' ';
  
       string s2 = j.ql.Contract_Duration1__c;
       System.debug('This is s2'+  ' ' +s2); //till here
       
       if(s2.containsIgnoreCase('Months'))
       {
           s3 = s2.substring(0,1);
           System.debug('This is s3'+  ' ' +s3); //till here 
       }
       if(s2.containsIgnoreCase('Days'))
       {
           s4 = s2.substring(0,2);
           System.debug('This is s4'+  ' ' +s4); //till here 
       }*/
    
           system.debug('numberDaysDue ---->'+numberDaysDue);
           system.debug('Start_Date__c ---->'+j.ql.Start_Date__c);
           system.debug('End_Date__c ---->'+j.ql.End_Date__c);
           system.debug('Contract_Duration1__c ---->'+j.ql.Contract_Duration1__c);
           
    if(CurrentUserId  != RajprofileId) 
    {  //if User is not belongs to CR Team start date cannot be less than today   
    if( j.ql.Start_Date__c < system.today() )
    {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Ensure Start Date is greater or equal to today'));
    return null;
    }
    } 
   else {
    
    date Prevdate =  system.today() - 15;
    system.debug('Prevdate--->'+Prevdate);
    
    if( j.ql.Start_Date__c < Prevdate ){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Ensure Start Date is not less than 15 Days from today'));
    return null;
    } 
    }
    if(j.ql.End_Date__c <= j.ql.Start_Date__c ){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date should be greater than Start Date'));
    return null;
    }
    if(numberDaysDue > 366){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Duration cannot be greater than 12 Months'));
    return null;
    }
       //@yam added 
    if(j.ql.Contract_Duration1__c == '6 Months' && numberDaysDue != 183 && j.ql.Product__r.Name !='Custom Sponsorship')
    {
        
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date cannot be greater/lesser than Contract Duration : 6 Months'));
             return null;
    }
        
    else if(j.ql.Contract_Duration1__c == '3 Months' && numberDaysDue != 92 && j.ql.Product__r.Name !='Custom Sponsorship')
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date cannot be greater/lesser than contract duration : 3 Months'));
             return null;
    }
    else if(j.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 30 && j.ql.Product__r.Name !='Custom Sponsorship'  )
    {
      //(month31 == 1 || month31 == 3 || month31 == 5 || month31 == 7 || month31 == 8 || month31 == 10 || month31 == 12) &&
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration 1 Months(30 days)'));
             return null;
    }
     
     else if( j.ql.Contract_Duration1__c == '2 Months' && numberDaysDue != 61 )
    {
        If((j.ql.Product__r.Name !='Custom Sponsorship')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End Date cannot be greater/lesser than Contract Duration : 2 Months(61 days)'));
             return null;
        }
    }
    /* else if( (month31 == 4 || month31 == 6 || month31 == 9 || month31 == 11)  && j.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 30 ) 
    {
      
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration 1 Months(30 days)'));
             return null;
    }
       
     else If( (month31 == 2) && (j.ql.Contract_Duration1__c == '1 Month' && numberDaysDue != 29) )
    {
           System.debug('contract duration--------->'+j.ql.Contract_Duration1__c);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'End date  cannot be greater/lesser than contract duration 1 Month (29 days)'));
             return null;
    }*///@yam
        
    /*if( (s1 != s3))
    {
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please add the end date equal to the contract duration'));
         return null;
    }*/
    
   //till here
   
   list_to_update.add(j.ql);
   }
   
   
  update list_to_update;
  wlist=new list<wrapp>();
   for(Proposal_Line_Item__c nn:[SELECT Id,Free_Trail__c,Product__r.Trail_Custom_or_Promo__c,Comment__c,Price_After_Discount__c,Total_Discount__c,Base_Total__c ,Price__c,Gross_Total__c , IsDeleted,End_Date__c,Start_Date__c, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Product__c, Adjustment_Amount__c, Adjustment_Type__c, Quantity__c, Proposal_Locked__c, Status__c,Contract_Duration1__c FROM Proposal_Line_Item__c WHERE Proposal_Locked__c=: qid order by createddate])
{
wlist.add(new wrapp(nn));


} 
    qq=[select id ,ownerid ,Approval_Status__c,Level_of_Approval__c,PriceList__c from apttus_proposal_proposal__c where id=:qid limit 1];
    if(qq.Approval_Status__c=='Required Approval')
    {
    b2=true;
    
    
    }else
    {
    
    b2=false;
    }
    
      return new pagereference('/'+qid);
      
      }catch(exception e){
     // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,e.getMessage()));
       ApexPages.addMessages(e);
       return null;
      }
    }
////////////////////////////////////////////////////////////////check approval//////////////////////////////////////////////////////////////////////    
public pagereference check_approval()
{
return new pagereference('/apex/CustomApprovalProcessController?id='+rem);
}
    
    
/////////////////////////////////////////////////Reconfig//////////////////////////////////////////////////////////////////////////
public pagereference Recongif()
{list<Proposal_Line_Item__c> list_to_update=new list<Proposal_Line_Item__c>();
   
   for(wrapp j:wlist)
   {
   list_to_update.add(j.ql);
   }
   
   
  update list_to_update;
  pagereference pf;
  if(TCP==true){
  pf= new pagereference('/apex/reconfigure_TCP?id='+rem+'&source=q_discount');}
  else{
  pf= new pagereference('/apex/reconfigure?id='+rem+'&source=q_discount');}
 pf.setredirect(false);
return pf;

}


/////////////////////////////////////////////////////////////////// submit method///////////////////////////////////////////////////////////////////////////
public pagereference submit()
{
Approval.ProcessSubmitRequest req1 = 
            new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(qq.id);
        
        // Submit on behalf of a specific submitter
        req1.setSubmitterId(qq.ownerId); 
        
        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('Discount_Approval_Process');
        req1.setSkipEntryCriteria(false);
        
        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
return new pagereference('/'+qid);

}





}