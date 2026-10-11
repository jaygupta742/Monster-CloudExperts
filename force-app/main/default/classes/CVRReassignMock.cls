@isTest
global class CVRReassignMock implements HttpCalloutMock // to call the httppost method 
{
    global HTTPResponse respond(HTTPRequest request)
    {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/');
         response.setBody('{"Name":"'+  +'"}');
         response.setStatusCode(200);
        return response; 
    }
}