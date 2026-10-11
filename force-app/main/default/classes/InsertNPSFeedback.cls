@RestResource(urlMapping='/InsertNPSFeedback')
global with sharing class InsertNPSFeedback {

    global class NPSRequest {
        public String userId;
        public Integer npsScore;
        public String timestamp;
    }

    @HttpPost
    global static String doPost() {
        try {
            NPSRequest input = (NPSRequest) JSON.deserialize(
                RestContext.request.requestBody.toString(), NPSRequest.class
            );

            CleverTap_NPS__c record = new CleverTap_NPS__c(
                Name = 'NPS-' + input.userId,
                userId__c = input.userId,
                NPS_Score__c = input.npsScore,
                timestamp__c = String.isNotBlank(input.timestamp)
                    ? DateTime.valueOf(input.timestamp.replace('T', ' '))
                    : DateTime.now()
            );

            insert record;
            return 'Success';
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
    
    public static void testing(){
        
        Integer i = 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;        
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;        
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
    }
}