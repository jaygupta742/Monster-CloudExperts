@isTest
global class MockHttpResponseGenerator13 implements HttpCalloutMock {
global HTTPResponse respond(HTTPRequest req) {
        
  system.assertEquals('https://apiv3.monsterindia.com/sfpview/sfpview.php?email=amitsingh2142@gmail.com', req.getEndpoint());

        
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"status":"SUCCESS","token":"00349c645430ddba","secret":"$2y$11$607bc2e5e5a14d01fc294OyuqMSvNY1xCO2IXVh4T2/HGJBszc1bK","expiry":"27-May-2022 14:49:52"}');
        response.setStatusCode(200);
        return response; 
    }
}