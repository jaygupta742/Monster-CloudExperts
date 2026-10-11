@Istest
public class PA_Owner_Assignment_Scheduler_Test {
	@Istest
    Public static void myPAOAtmeth(){
        PA_Owner_Assignment__c p = new PA_Owner_Assignment__c();
        p.Name = 'Pramodh';
        p.Count__c = 10;
        p.Location__c = 'India';
        insert p;
        System.schedule('PA count 0', '0 0 * * * ? *', New PA_Owner_Assignment_Scheduler());
    }
}