@istest
global class DragAndDropRESTAPI_Test implements HttpCalloutMock  {

    global HttpResponse respond(HttpRequest req){
        httpResponse resp= new httpResponse();
        resp.setHeader('Content-type','Application/json');
        resp.getBody();
        resp.setStatusCode(200);
        return resp;
    }
}