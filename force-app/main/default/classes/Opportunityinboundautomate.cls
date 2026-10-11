public class Opportunityinboundautomate {

   // public String SenderEmail { get; set; }
    
    public String getCcmoinbound() {
        return null;
    }
     public String getCcsndngto() {
        return null;
    }
     

// developer name Rajaprashanth 

public Opportunity__c  opquer{get;set;}
 list<string> ccmoinbound {get;set;}
  list<string> sndngto {get;set;}
public string comment{get;set;}
public user uu{get;set;}
public id curpgid; 
public id ids;
// for cc address
public string ccad{get;set;}
// for to address
public string ccbd{get;set;}

public string bud{get;set;} 
public string auth{get;set;}
public string ned{get;set;}
public string tym{get;set;} 
public string poten{get;set;} 
public string com{get;set;} 
public boolean a;
 public string query;
// for attchment
public blob attbody{get;set;}
public string attname{get;set;}
public String stringDate1;
public string stringDate2;
    public Opportunityinboundautomate (){
   a= false;
       //OrgWideEmailAddress owea = [select id,Address from OrgWideEmailAddress where Address ='inboundleads@monsterindia.com'];
        
    curpgid = ApexPages.CurrentPage().getParameters().get('id');
    opquer =[select id,name,Description__c,OpportunitySource__c,Competitor__c,Potential__c,OpportunityType__c,createdDate,LastModifiedDate ,Contact__c,Contact__r.name,Account__r.name,Account__r.AccountID__c,Account__r.AccountStatus__c,Account__r.ShippingCity,Account__r.ShippingCountry,Account__r.SalesChannel__c,ownerID from Opportunity__c where id =: curpgid];
     system.debug('cddddddddddddddddddddddddddd------>>>>'+opquer.createdDate );
   // query =opquer.createdDate.formatGMT('yyyy-MM-dd/hh:mm',userTimeZone);

    String userTimeZone = UserInfo.getTimeZone().getID();
    System.debug('Time zone-----------'+userTimeZone);
    Datetime dateTimeInGMT=opquer.createdDate; 
    stringDate1=dateTimeInGMT.format('MM/dd/yyyy h:m a');
   
    //String tmconv = dateTimeInGMT.format(''MM/dd/yyyy HH:mm a'');
    //System.debug('date-----------'+tmconv);    
    
    
    uu = new User();
    
    uu = [Select id,name,Email,Manager_Email__c from user where id=:opquer.OwnerID];
    system.debug('uuuuuuuuuuuuuuuuu'+uu);
    ccad = uu.Manager_Email__c;
   ccbd = uu.Email;
    
    
    }
    
    
   
public pagereference oppmail(){
            
        OrgWideEmailAddress   owea = [select Id,address from OrgWideEmailAddress where address=:'inboundleads@monsterindia.com'];
        list<Messaging.SingleEmailMessage>  listofmails = new list<Messaging.SingleEmailMessage>();
        
            Messaging.SingleEmailMessage inbond = new Messaging.SingleEmailMessage();
            
     ccmoinbound = new list<string>();
     sndngto = new list<string>();
    ccmoinbound.add(owea.Address);
    sndngto.add(owea.Address);
  
   ccmoinbound.add('chintala.swapna@monsterindia.com');
    ccmoinbound.add('yasmine.yaqub@monsterindia.com');
    //ccmoinbound.add('suresh.babu@monsterindia.com');
   //sndngto.add('chintala.swapna@monsterindia.com');
 // sndngto.add('yasmine.yaqub=monsterindia.com@example.com');
    if(ccad==null)
    {
     ccmoinbound.add(uu.Email);
    
     }
 // if(ccad !  = null){
/*if(ccad != null){
    list<string> spltcad = ccad.split(',');
    ccmoinbound.addall(spltcad);
    // sndngto.addall(spltcad);
   
     ccad=uu.Manager_Email__c;
     ccbd=uu.Email;
    
}*/

    
     
     
    if(ccbd != null || ccad != null) 
    {
    list<string> spltcad1 = ccbd.split(',');
    sndngto.addall(spltcad1); 
    list<string> spltcad = ccad.split(',');
    ccmoinbound.addall(spltcad);
     ccad=uu.Manager_Email__c;
     ccbd=uu.Email;
   
}
    
    
    
/*else if(ccad != null){
    list<string> spltcad = ccad.split(',');
    ccmoinbound.addall(spltcad);
    // sndngto.addall(spltcad);
   
     ccad=uu.Manager_Email__c;
     ccbd=uu.Email;
    }*/
 
         /*  list<string> sndngto = new list<string>();
          sndngto.add(ccbd);
            
    if(uu.Email!= null){
        sndngto.add(uu.Manager_Email__c); 
    }
    // system.debug('record oooowwwwwww email'+ uu.email);     
    if(uu.Manager_Email__c != null){
       sndngto.add(uu.Email);
            system.debug('record managggggggg email'+ uu.Manager_Email__c); 
            system.debug('sfjfhgjf'+uu.Email);
    }*/
             
                         inbond.setOrgWideEmailAddressId(owea.id);
              //sndngto.add(uu.Email);
            inbond.setToAddresses(sndngto);
            system.debug('toadddddddddddd'+sndngto);
   inbond.setCcAddresses(ccmoinbound);
     
    system.debug('ccccccccccc'+ccmoinbound);
    
            inbond.setSubject('Inbound Lead '+opquer.Account__r.SalesChannel__c);
            
     
            string body ='<table border="1" cellspacing="0" cellpadding="1"><th>Account _ID  </th>';
             body+='<th> Account Name </th>';
             body+='<th> Posting City  </th>';
            body+='<th> Posting Country </th>';
            body+='<th>Contact Name  </th>';
            body+= '<th>Opportunity -ID  </th>';
             body+='<th>Created date   </th>';
             
             body+='<th>Opportunity source </th>';
             //body+='<th>Opportunity Description </th>';
             body+='<th> comments </th>';
             
          body+='<tr><td>'+opquer.Account__r.AccountID__c+'</td>';
           body+='<td>'+opquer.Account__r.Name+'</td>';
           body+='<td>'+opquer.Account__r.ShippingCity+'</td>';
            body+='<td>'+opquer.Account__r.ShippingCountry+'</td>';
           body+='<td>'+opquer.Contact__r.name +' </td>';
           body+='<td>'+opquer.name +' </td>';
           body+='<td>'+stringDate1+' </td>';
           body+='<td>'+opquer.OpportunitySource__c +' </td>';
          // body+='<td>'+opquer.Description__c +' </td>';
          body+='<td>'+ comment + '</td></tr></table>';
        
                    
            string bod ;
           
           // bod= '<table border="1" cellspacing="0"><tr> <b>Budget </b><td>'+ bud +'</td> </tr> <tr><b> Authority</b> <td>'+ auth +' </td> </tr> <tr><b> Need </b><td>'+ Ned +' </td> </tr> <tr><b>Timing</b> <td>'+tym +' </td> </tr></table>';
          
          //bod ='<table border="1" cellspacing="0"> <tr><b>Budget</b><br/>'+bud+'  </tr> <tr><b>Authority </b><br/> '+auth+' </tr> <tr><b>Need </b><br/> '+Ned+' </tr>  <tr><b>Timing</b><br/> '+tym+' </tr></table>';
          if(poten=='High'||poten=='high'){
        bod ='<table border="1" cellspacing="0"> <tr><b> Budget </b><td>'+bud+' </td></tr> <tr><b>Authority </b><td> '+auth+'</td></tr>   <tr><b> Need </b><td > '+Ned+'</td> </tr>  </tr>  <tr><b>Timing</b><td> '+tym+'</td></tr>  <tr style="background-color:green"><b> Potentional </b><td style="background-color:green"> '+poten+'</td> </tr> <tr><b> Competitor </b><td> '+com+'</td>  </table>';
          }
          
           //bod ='<table border="1" cellspacing="0"> <tr><b>Budget</b><br/>'+bud+'  </tr> <tr><b>Authority </b><br/> '+auth+' </tr> <tr><b>Need </b><br/> '+Ned+' </tr>  <tr><b>Timing</b><br/> '+tym+' </tr></table>';
         else if(poten=='Medium'||poten=='medium'){
        bod ='<table border="1" cellspacing="0"> <tr><b> Budget </b><td>'+bud+' </td></tr> <tr><b>Authority </b><td> '+auth+'</td></tr>   <tr><b> Need </b><td > '+Ned+'</td> </tr>  <tr><b>Timing</b><td> '+tym+'</td></tr>  <tr style="background-color:Orange"><b> Potentional </b><td style="background-color:Orange"> '+poten+'</td> </tr> <tr><b> Competitor </b><td> '+com+'</td> </tr>   </table>';
          }
          else{
        bod ='<table border="1" cellspacing="0"> <tr><b> Budget </b><td>'+bud+' </td></tr> <tr><b>Authority </b><td> '+auth+'</td></tr>   <tr><b> Need </b><td > '+Ned+'</td> </tr>   <tr><b>Timing</b><td> '+tym+'</td></tr> <tr style="background-color:Yellow"><b> Potentional </b><td style="background-color:Yellow"> '+poten+'</td> </tr> <tr><b> Competitor </b><td> '+com+'</td> </tr>   </table>';
          }
             inbond.setHtmlBody(body +'<br/>'+ bod+'<br/><br/>'+'Regards, <br/><br/><b> Lead Management Team.</b>' );
    
   if(attbody!= null){
    Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();  
   
   
  
   
    attachment.setFileName(attname);
           
          attachment.setBody(attbody);   
    
    attachment.setinline(true);  
    
    inbond.setFileAttachments(new Messaging.EmailFileAttachment[] {attachment});
       }    
          try{
           Messaging.sendEmail( new Messaging.SingleEmailMessage[] {inbond} );
           system.debug('emailsenttttttttt');
          } catch(exception e){
          
          system.debug('Email error'+e.getMessage());
          
          }
           
return new pagereference('/'+curpgid );
 
//}

}
}