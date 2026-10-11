public class getProfile {

    public PageReference goback() {
        return new pagereference('/'+recordId);
    }


public string sst{get;set;}
public String recordId {get; set;}

public getProfile() {

        recordId=ApexPages.currentPage().getParameters().get('id');
        account acc=[select id,name,Email__c from account where id=:recordId];
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://apiv3.monsterindia.com/sfpview/auth.php');
      
        req.setMethod('POST'); 
      
      
     req.setHeader('Content-Type','application/json');
     req.setHeader('Content-Type','multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW');
     req.setbody('------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"user\"\r\n\r\n'+'salesforce'+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"password\"\r\n\r\n'+'3HDrSOvRIs'+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--');
     
                Http h = new Http();
                System.debug('qqqqqqqqq');
                
                HTTPResponse res = h.send(req);
                System.debug(res.getBody());
               System.debug(req.getBody());
               JSON5Apex ghh=new JSON5Apex();
               ghh=(JSON5Apex)System.JSON.deserialize(res.getBody(), JSON5Apex.class);
               system.debug(ghh.token);
               
               
               HttpRequest req1 = new HttpRequest();
              
      
              req1.setMethod('GET');
              req1.setHeader('Token',ghh.token);
              req1.setHeader('Secret',ghh.secret);
              req1.setHeader('Content-Type','Application/Json');
              req1.setEndpoint('https://apiv3.monsterindia.com/sfpview/sfpview.php?email='+acc.Email__c);
              
              Http h1 = new Http();
                System.debug('qqqqqqqqq');
                
                HTTPResponse res1 = h1.send(req1);
                System.debug(res1.getBody());
               System.debug(req1.getBody());
               sst=res1.getBody();
               
}

public class JSON5Apex {
    public String status;
    public String token;
    public String secret;
    public String expiry;
        
        
    } 
}