@istest
global class MockHTTPCallout implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"address": "admin@cloudexpertsindia.com","status": "valid", "sub_status": "role_based_catch_all", "free_email": false, "did_you_mean": null, "account": "admin","domain": "cloudexpertsindia.com",'+
                    +'"domain_age_days": "4408", "smtp_provider": "g-suite", "mx_found": "true", "mx_record": "aspmx.l.google.com","firstname": null,"lastname": null,"gender": null,"country": null, "region": null,  "city": null,'+
                    +'"zipcode": null, "processed_at": "2023-10-05 09:05:52.177"}');
        res.setStatusCode(200);
        return res;
    }
    
}