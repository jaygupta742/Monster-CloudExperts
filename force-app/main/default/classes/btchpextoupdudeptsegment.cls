global class   btchpextoupdudeptsegment  implements Database.Batchable <sObject> {

map<id,user> ucermp = new map<id,user>([select id,name,department from user]);

global Database.QueryLocator start(Database.BatchableContext BC){

string query='select id,name,Segment__c,Old_Segment__c,ownerid from Account where Integration__c != true OR Person_Account__c != true ';


 return Database.getQueryLocator(query);




}

global void execute(Database.BatchableContext BC, List<Account> scope){

list<Account> rjac = new list<Account>();


for(Account ac:scope){

ac.Old_Segment__c = ac.Segment__c;

ac.Segment__c = ucermp.get(ac.ownerid).department;


}
update scope;
}

global void finish(Database.BatchableContext BC){

}





}