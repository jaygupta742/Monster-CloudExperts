public class ActivateOrderComponent {

    @AuraEnabled
    public static string sendforactivation(string rid){
        Order__c oo=[select id,name,Status__c,ownerid,Account__c,Account__r.Name,Account__r.AccountID__c,Sales_Channel__c,Order_Type__c,Gross_Total__c,
                     Contact__r.name,Contact__r.email,Contact__r.mobilephone,Comments__c,Order_Comment__c from Order__c where id=:rid];
        
        List<Order_Item_Services__c> oli=[select id,name,Status__c,Order__c from Order_Item_Services__c where Order__c=:rid];
        User uu=[select id,name,email,manager.email from User where id=:oo.OwnerId];
        
        List<string> str=new List<string>();
        str.add('activation@monsterindia.com');
        //str.add('anupshaw54321@gmail.com');
        
        List<string> cc=new List<string>();
        cc.add(uu.Email);
        cc.add(uu.manager.email);
        
        string link=URL.getSalesforceBaseUrl().toExternalForm() + '/'+oo.id;
        
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(str);
        mail.setCcAddresses(cc);
        mail.setSubject('Request For Activating the Services-'+oo.Name +' For '+oo.Account__r.Name);
        
        mail.setHtmlBody(
        '<b>Please activate the services</b> <br/><br/><br/> Account Name: '+oo.Account__r.name+'<br/>Account ID: '  +oo.Account__r.AccountID__c 
            +'<br/>Sales Channel: '+oo.Sales_Channel__c +'<br/>Account Sales Rep: '+uu.Name //Account__r.owner.name
            +'<br/>Order Type: '+oo.Order_Type__c+'<br/> Sales Credit: '+oo.Gross_Total__c
            +'<br/>Comments:'+oo.Order_Comment__c
            +'<br/><br/><b>Customer Contact Information: </b><br/>Name - '+oo.Contact__r.name
            +'<br/>Email - '+oo.Contact__r.email+'<br/>phone - '+oo.Contact__r.mobilephone
            +'<br/><br/>Regards,<br/>Team Finance'
            +'<br/><br/><b>Please click on the record link below for more details<br/>'+link
            );
         Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
               system.debug('msg sent:'+r);
        
        oo.Status__c='Sent For Activation';
        update oo;
        
        for(Order_Item_Services__c o:oli){
            o.Status__c='Sent For Activation';
        }
        update oli;
        
        return rid;

    }
}