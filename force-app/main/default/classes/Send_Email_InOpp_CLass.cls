public class Send_Email_InOpp_CLass {
    
    @AuraEnabled
    public static OpportunityN__c getOPLI(String rid)
    {
        OpportunityN__c o = new OpportunityN__c();
        o = [select Account__r.AccountID__c,Account__r.Name,Id,Name,Opportunity_Source__c,Account__r.AccountStatus__c,Account__r.ShippingCity,Account__r.ShippingCountry,Account__r.SalesChannel__c,Account__c,ownerId,owner.email,Contact__c,Contact__r.Name,createdDate from OpportunityN__c where Id=:rid];
        return o;
    }
    @AuraEnabled
    public static String getToAddress(String rid)
    {
        OpportunityN__c o = new OpportunityN__c();
        o = [select Id,Name,owner.email from OpportunityN__c where Id=:rid];
        String toadd = o.owner.email;
        system.debug('The To Address is  : '+toadd);
        return toadd;
    }
    @AuraEnabled
    public static String getCCAddress(String rid)
    {
        OpportunityN__c o = new OpportunityN__c();
        o = [select Id,Name,ownerId from OpportunityN__c where Id=:rid];
        User u = [select Id,Manager_Email__c from User where Id=:o.ownerId];
        String ccadd = u.Manager_Email__c;
        system.debug('The CC Address is  : '+ccadd);
        return ccadd;
    }
    @AuraEnabled
    public static void sendemailmethod(String bud,String auth,String need, String timing, String poten, String rid, String cc,String to,OpportunityN__c opp,String com)
    {
        System.debug('The to in send email is : '+to);
        OrgWideEmailAddress owea = [select Id,address from OrgWideEmailAddress where address=:'inboundleads@monsterindia.com'];
        
        list<Messaging.SingleEmailMessage>  listofmails = new list<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage inbond = new Messaging.SingleEmailMessage();
        
        Datetime dateTimeInGMT=opp.createdDate; 
        String stringDate1=dateTimeInGMT.format('MM/dd/yyyy h:m a');
        
        list<String> toadd = new list<String>();
        list<String> ccadd = new list<String>();
        
        if(cc!=null)   
        {
            list<string> morecc = cc.split(',');
            ccadd.addall(morecc);
        }
        if(to!=null){
            list<String> moreto= to.split(',');
            toadd.addall(moreto);
        }
        User u = [select Id,Name,Manager_Email__c from User where Id=:opp.ownerId];
        String manageremail = u.Manager_Email__c;
        String owneremail = opp.owner.email;
        System.debug('The owner email is  : '+owneremail);
        toadd.add(owneremail);
        // toadd.add('subhadeepdas2199@gmail.com');
        if(manageremail != null){
            ccadd.add(manageremail);
        }
        
        ccadd.add(owea.Address);
        ccadd.add('chintala.swapna@monsterindia.com');
        ccadd.add('yasmine.yaqub@monsterindia.com');
        
        string body ='<table border="1" cellspacing="0" cellpadding="1"><th>Account _ID  </th>';
        body+='<th> Account Name </th>';
        body+='<th> Posting City  </th>';
        body+='<th> Posting Country </th>';
        body+='<th>Contact Name  </th>';
        body+= '<th>Opportunity -ID  </th>';
        body+='<th>Created date   </th>';
        
        body+='<th>Opportunity source </th>';
        
        
        
        body+='<tr><td>'+opp.Account__r.AccountID__c+'</td>';
        body+='<td>'+opp.Account__r.Name+'</td>';
        body+='<td>'+opp.Account__r.ShippingCity+'</td>';
        body+='<td>'+opp.Account__r.ShippingCountry+'</td>';
        body+='<td>'+opp.Contact__r.name +' </td>';
        body+='<td>'+opp.name +' </td>';
        body+='<td>'+stringDate1+' </td>';
        //  body+='<td>'+opp.OpportunitySource__c +' </td>';
        // body+='<td>'+opquer.Description__c +' </td>';
        body+='<td>'+ opp.Opportunity_Source__c + '</td></tr></table>';
        
        String bod;
        if(poten=='High'||poten=='high'){
            bod ='<table border="1" cellspacing="0"> <tr><b> Budget </b><td>'+bud+' </td></tr> <tr><b>Authority </b><td> '+auth+'</td></tr>   <tr><b> Need </b><td > '+need+'</td> </tr>  </tr>  <tr><b>Timing</b><td> '+timing+'</td></tr>  <tr style="background-color:green"><b> Potentional </b><td style="background-color:green"> '+poten+'</td> </tr> <tr><b> Competitor </b><td> '+com+'</td>  </table>';
        }
        
        //bod ='<table border="1" cellspacing="0"> <tr><b>Budget</b><br/>'+bud+'  </tr> <tr><b>Authority </b><br/> '+auth+' </tr> <tr><b>Need </b><br/> '+Ned+' </tr>  <tr><b>Timing</b><br/> '+tym+' </tr></table>';
        else if(poten=='Medium'||poten=='medium'){
            bod ='<table border="1" cellspacing="0"> <tr><b> Budget </b><td>'+bud+' </td></tr> <tr><b>Authority </b><td> '+auth+'</td></tr>   <tr><b> Need </b><td > '+need+'</td> </tr>  <tr><b>Timing</b><td> '+timing+'</td></tr>  <tr style="background-color:Orange"><b> Potentional </b><td style="background-color:Orange"> '+poten+'</td> </tr> <tr><b> Competitor </b><td> '+com+'</td> </tr>   </table>';
        }
        else{
            bod ='<table border="1" cellspacing="0"> <tr><b> Budget </b><td>'+bud+' </td></tr> <tr><b>Authority </b><td> '+auth+'</td></tr>   <tr><b> Need </b><td > '+need+'</td> </tr>   <tr><b>Timing</b><td> '+timing+'</td></tr> <tr style="background-color:Yellow"><b> Potentional </b><td style="background-color:Yellow"> '+poten+'</td> </tr> <tr><b> Competitor </b><td> '+com+'</td> </tr>   </table>';
        }
        System.debug('The To add is  : '+toadd);
        System.debug('The CC add is  : '+ccadd);
        inbond.setToAddresses(toadd);
        inbond.setCcAddresses(ccadd);
        inbond.setSubject('Inbound Lead '+opp.Account__r.SalesChannel__c);
        inbond.setHtmlBody(body +'<br/>'+ bod+'<br/><br/>'+'Regards, <br/><br/><b> Lead Management Team.</b>' );
        
        listofmails.add(inbond);
        System.debug('Sending mail');
        Messaging.sendEmail(listofmails);
        
        
        
    }
}