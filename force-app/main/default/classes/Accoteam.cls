public class Accoteam {

public list<Account_Team_Member__c> atm{get;set;}
public Account acTeam {get;set;}
public string acTeamid{get;set;}
list<Account_Team_Member__c> accteamembertoupsert;
    boolean error= false;

public void Accoteam()
{

atm= new list<Account_Team_Member__c>();
atm=[select id , name,AccountAccessLevel__c,OpportunityAccessLevel__c,CaseAccessLevel__c,TeamMemberRole__c,UserId__c from Account_Team_Member__c];
    
    
}

    public void saveall(){
        
        atm = new list<Account_Team_Member__c>();
        insert atm;
        
    }
    
    

}