// Last Modified By : Abdul Aziz , Date : 11/07/2023 , Replaced old monster email to foundit

public class EventSendTemplate {
    
    Public Event e {get;set;}
    public id currentpgid;
    public id currentUserId;
    public string toaddr{get;set;}
    public User uu{get;set;}
    public string ccaddr{get;set;}
    public string comment{get;set;}
    public string bud{get;set;}
    public string auth{get;set;}
    public String ned{get;set;}
    public string tym{get;set;}
    public string poten{get;set;}
    public string com{get;set;}
    public string dispo{get;set;}
    public blob attbody{get;set;}
    public string attname{get;set;}
    Public list<string> sndngto {get;set;}
    Public list<string> ccmoinbound {get;set;}
    Public contact c{get;set;}
    Public String ContactName {get;set;}
    public String OppoNumber{get;set;}
    Public String OppoType{get;set;}
    Public string OppoSource {get;set;}
    public String stringDate1;
    
    public String currentlyHiring { get; set; }
    public String openPositions { get; set; }
    public String numPositions { get; set; }
    public String existingPortals { get; set; }
    public String designation { get; set; }
    public String decisionMakerLoc { get; set; }
    public Datetime demoDateTime { get; set; }
    public String competitorPosting { get; set; }
    public String basicServices { get; set; }
    public String rolesToClose { get; set; }
    
    
    public EventSendTemplate()
    {
        currentpgid =ApexPages.CurrentPage().getParameters().get('id');
        currentUserId = UserInfo.getUserId();
        sndngto  = new List<string>();
        e =[select id,WhatId,OwnerID,WhoId,Event_Source__c,owner.Name,createdDate,Account.SalesChannel__c,Account.CreditStatus__c,Account.AccountStatus__c,Account.AccountID__c,Account.ShippingCity,Account.ShippingCountry,Account.Name from Event where id=:currentpgid];
        List<Account> acc = new List<Account>();
        acc= [select Id,Name,(Select Name,AccountId,PrimarySalesContact__c,PrimaryServiceContact__c from Contacts),(Select Name,Account__c,Contact__c,OpportunityType__c,OpportunitySource__c from Opportunities__r)  from Account where id=:e.WhatId];
        system.debug('This is the details for this account'+acc);
        for(Account a : acc)
        {
            for(Contact c : a.Contacts)
            {
                if(c.AccountId == a.id && c.PrimarySalesContact__c == true)
                {
                    System.debug('this contact belongs to '+c.Name);
                    ContactName =c.Name;
                }
                for(Opportunity__c oo : a.Opportunities__r)
                {
                    if(oo.Account__c == a.id && oo.Contact__c == c.id)
                    {
                        OppoNumber = oo.Name;
                        OppoType = oo.OpportunityType__c;
                        OppoSource = oo.OpportunitySource__c;
                    }
                    
                }
            }
        }
        
        String userTimeZone = UserInfo.getTimeZone().getID();
        System.debug('Time zone-----------'+userTimeZone);
        Datetime dateTimeInGMT=e.createdDate; 
        stringDate1=dateTimeInGMT.format('MM/dd/yyyy h:m a');
        
        
        //for toaddr and ccaddr
        uu = new User();
        uu = [Select id,name,Email,Manager_Email__c from user where id=:e.OwnerID]; 
        if(uu.Manager_Email__c!=null && uu.Manager_Email__c !='anurag.arora@foundit.ai') // Changed email from anurag.arora@monsterindia.com to anurag.arora@foundit.ai 
        { 
            ccaddr = uu.Manager_Email__c;  
        }
        else
            ccaddr = uu.email; 
        toaddr = uu.Email;
        
        
    }
    
    
    
    public PageReference evemail() {
        
        OrgWideEmailAddress owea = [select Id,address from OrgWideEmailAddress where address=:'inboundleads@foundit.in']; // Changed email from inboundleads@monsterindia.com to inboundleads@foundit.in
        User usr = [Select id,name,Email,Manager_Email__c from user where id=:currentUserId]; 
        Messaging.SingleEmailMessage inbond = new Messaging.SingleEmailMessage(); 
        ccmoinbound = new list<string>();
        ccmoinbound.add('chintala.swapna@foundit.ai'); //changed email from chintala.swapna@monsterindia.com to chintala.swapna@foundit.ai
        ccmoinbound.add('yasmine.yaqub@foundit.ai'); //changed email from yasmine.yaqub@monsterindia.com to yasmine.yaqub@foundit.ai
        ccmoinbound.add('inboundleads@foundit.in'); // Changed email from inboundleads@monsterindia.com to inboundleads@foundit.in
        if(ccaddr!=null)
        {
            ccmoinbound.add(uu.Email); 
        }
        
        
        if(toaddr != null || ccaddr != null) 
        {
            list<string> spltcad1 = toaddr.split(',');
            sndngto.addall(spltcad1); 
            
            list<string> spltcad = ccaddr.split(',');
            ccmoinbound.addall(spltcad);
            ccaddr =uu.Manager_Email__c;
            toaddr =uu.Email;
            
        }
        inbond.setOrgWideEmailAddressId(owea.id);
        inbond.setToAddresses(sndngto);          
        system.debug('toadddddddddddd'+sndngto);
        inbond.setCcAddresses(ccmoinbound);
        system.debug('ccccccccccc'+ccmoinbound);
        
        // when sending a mail this table should be showed 
        // 
        if(e.Event_Source__c == 'Recruiter profile'){
            inbond.setSubject('Recruiter profile lead '+e.Account.SalesChannel__c);
        }
        else
            if(e.Event_Source__c == 'Competitor'){
                inbond.setSubject('Competitor lead '+e.Account.SalesChannel__c);
            }
        else
            if(e.Event_Source__c == 'LinkedIn'){
                inbond.setSubject('LinkedIn lead '+e.Account.SalesChannel__c);
            }
        /*telemaket*/
        else
            if(e.Event_Source__c == 'Telemarketing'){
                inbond.setSubject('Telemarketing lead '+e.Account.SalesChannel__c);
            }
        /*Webinar*/
        else
            if(e.Event_Source__c == 'Webinar'){
                inbond.setSubject('Webinar lead '+e.Account.SalesChannel__c);
            }
        else 
        {  
            inbond.setSubject('Inbound Lead '+e.Account.SalesChannel__c);  
            
        }
        
        
        string body ='<table border="1" cellspacing="0" cellpadding="1"><th>Account _ID  </th>';
        body+='<th> Account Name </th>';
        body+='<th> Posting City  </th>';
        body+='<th> Posting Country </th>';
        body+='<th>Contact Name  </th>';
        body+='<th>Created date   </th>';
        body+='<th>Event Source</th>';
        body+='<th>Assigned To</th>';
        body+='<th>Status</th>';
        body+='<th>Credit Status</th>';
        
        body+='<th> comments </th>';
        
        //table values 
        body+='<tr><td>'+e.Account.AccountID__c+'</td>';
        body+='<td>'+e.Account.Name+'</td>';
        body+='<td>'+e.Account.ShippingCity+'</td>';
        body+='<td>'+e.Account.ShippingCountry+'</td>';
        body+='<td>'+ContactName+' </td>';
        body+='<td>'+stringDate1+' </td>';
        body+='<td>'+e.Event_Source__c+' </td>';
        body+='<td>'+e.owner.name+' </td>';
        body+='<td>'+e.Account.AccountStatus__c+' </td>';// for status 
        body+='<td>'+e.Account.CreditStatus__c+'</td>';
        body+='<td>'+ comment + '</td></tr></table>';
        
        // for potential colour 
        
        string bod ;
        
        String rowColor = 'white'; 
        String p = (poten != null) ? poten.toLowerCase() : '';
        
        if (p == 'high') {
            rowColor = 'green';
        } else if (p == 'medium') {
            rowColor = 'orange';
        } else if (p == 'na') {
            rowColor = 'yellow';
        }
        
        // 2. Build the body with descriptive labels
       /* bod = '<table border="1" cellspacing="0" cellpadding="5" style="border-collapse: collapse; font-family: Arial, sans-serif;">' +
            '<tr><td style="width: 200px;"><b>Budget allocated for recruitment tools</b></td><td>' + (bud != null ? bud : '') + '</td></tr>' +
            '<tr><td><b>Decision Maker or Influencer or others</b></td><td>' + (auth != null ? auth : '') + '</td></tr>' +
            '<tr><td><b>How many positions to close</b></td><td>' + (Ned != null ? Ned : '') + '</td></tr>' +
            '<tr><td><b>Timelines to close the requirements</b></td><td>' + (tym != null ? tym : '') + '</td></tr>' +
            '<tr style="background-color:' + rowColor + '"><td><b>Lead Potential</b></td><td>' + (poten != null ? poten : '') + '</td></tr>' +
            '<tr><td><b>Currently Hiring?</b></td><td>' + (currentlyHiring != null ? currentlyHiring : '') + '</td></tr>' +
            '<tr><td><b>Number of Open Positions/Roles</b></td><td>' + (numPositions != null ? numPositions : '') + '</td></tr>' +
            '<tr><td><b>Existing Job Portals in Use</b></td><td>' + (existingPortals != null ? existingPortals : '') + '</td></tr>' +
            '<tr><td><b>Designation / Job Title</b></td><td>' + (designation != null ? designation : '') + '</td></tr>' +
            '<tr><td><b>Decision maker from same location or Different</b></td><td>' + (decisionMakerLoc != null ? decisionMakerLoc : '') + '</td></tr>' +
            '<tr><td><b>Demo/Initial date & time</b></td><td>' + (demoDateTime != null ? demoDateTime.format() : '') + '</td></tr>' +
            '<tr><td><b>Posting on Competitor Sites</b></td><td>' + (competitorPosting != null ? competitorPosting : '') + '</td></tr>' +
            '<tr><td><b>Disposition</b></td><td>' + (dispo != null ? dispo : '') + '</td></tr>' +
            '</table>'; */
        
        bod = '<table border="1" cellspacing="0" cellpadding="5" style="border-collapse: collapse; font-family: Arial, sans-serif;">' +
            
            // 1. Disposition
            '<tr><td style="width: 200px;"><b>Disposition</b></td><td>' + (dispo != null ? dispo : '') + '</td></tr>' +
            
            // 2. Currently Hiring?
            '<tr><td><b>Currently Hiring?</b></td><td>' + (currentlyHiring != null ? currentlyHiring : '') + '</td></tr>' +
            
            // 3. Number of Open Positions/Roles
           // '<tr><td><b>Number of Open Positions/Roles</b></td><td>' + (openPositions != null ? openPositions : '') + '</td></tr>' +
            
            // 4. How many positions to close
            '<tr><td><b>How many positions to close</b></td><td>' + (numPositions != null ? numPositions : '') + '</td></tr>' +
            
            '<tr><td><b>What roles are you planning to close</b></td><td>' + (rolesToClose != null ? rolesToClose : '') + '</td></tr>' +
            
            // 5. Decision Maker or Influencer or others
            '<tr><td><b>Decision Maker or Influencer or others</b></td><td>' + (auth != null ? auth : '') + '</td></tr>' +
            
            // 6. Designation / Job Title
            '<tr><td><b>Designation / Job Title</b></td><td>' + (designation != null ? designation : '') + '</td></tr>' +
            
            // 7. Decision maker from same location or Different
            '<tr><td><b>Decision maker from same location or Different</b></td><td>' + (decisionMakerLoc != null ? decisionMakerLoc : '') + '</td></tr>' +
            
            // 8. Timelines to close the requirements
            '<tr><td><b>Timelines to close the requirements</b></td><td>' + (tym != null ? tym : '') + '</td></tr>' +
            
            // 9. Budget allocated for recruitment tools
            '<tr><td><b>Budget allocated for recruitment tools</b></td><td>' + (bud != null ? bud : '') + '</td></tr>' +
            
            // 10. Existing Job Portals in Use
            '<tr><td><b>Existing Job Portals in Use</b></td><td>' + (existingPortals != null ? existingPortals : '') + '</td></tr>' +
            
            // 11. Posting on Competitor Sites
            '<tr><td><b>Posting on Competitor Sites</b></td><td>' + (competitorPosting != null ? competitorPosting : '') + '</td></tr>' +
            
            // 12. Demo/Initial date & time
            '<tr><td><b>Demo/Initial date & time</b></td><td>' + (demoDateTime != null ? demoDateTime.format() : '') + '</td></tr>' +
            
            '<tr><td><b>Basic Services Or Other</b></td><td>' + (basicServices != null ? basicServices : '') + '</td></tr>' +
            
            // 13. Lead Potential
            '<tr style="background-color:' + rowColor + '"><td><b>Lead Potential</b></td><td>' + (poten != null ? poten : '') + '</td></tr>' +
            
            
            
            '</table>';

        
        /* else if(poten=='Low'||poten=='low')
{
bod ='<table border="1" cellspacing="0"> <tr><b> Budget </b><td>'+bud+' </td></tr> <tr><b>Authority </b><td> '+auth+'</td></tr>   <tr><b> Need </b><td > '+Ned+'</td> </tr>   <tr><b>Timing</b><td> '+tym+'</td></tr> <tr style="background-color:Yellow"><b> Potentional </b><td style="background-color:Yellow"> '+poten+'</td> </tr> <tr><b> Competitor </b><td> '+com+'</td> </tr>   </table>';
}*/
        
        inbond.setHtmlBody(body +'<br/>'+ bod+'<br/><br/>'+'Regards, <br/><br/><b> Lead Management Team.</b>');
        
        if(attbody!= null)  
        { 
            Messaging.EmailFileAttachment  attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName(attname);
            attachment.setBody(attbody);   
            attachment.setinline(true);
            inbond.setFileAttachments(new Messaging.EmailFileAttachment[] {attachment});  
        }
        try{
            Messaging.sendEmail( new Messaging.SingleEmailMessage[] {inbond} );
            system.debug('emailsenttttttttt');
        } 
        
        catch(exception e){
            
            system.debug('Email error'+e.getMessage());
            
        }
        return new pagereference('/'+currentpgid );
    }
    
    
}