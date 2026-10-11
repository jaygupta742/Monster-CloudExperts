public class editall {

string recid;

public list<Contract_Line_Item__c> cl{get;set;}

    public editall()
    { recid=apexpages.currentpage().getparameters().get('cc');
       cl= [SELECT Id, Name, Green_Sheet__c, Employer__c, Staff_Category__c,Other_Employee__c, Service_Category__c, Skill_Category__c, Working_Hour_X_days__c, No_of_Employees__c, Basic_Salary__c, HRA__c, DA__c, Spl_Other_Allowances__c, Washing_Allowance__c, Gross_Salary__c, PF__c, ESI__c, Bonus__c, Gratuity__c, Ex_Gratia__c, Leaves__c, Uniform_Cost__c, LWF__c, OT_Amount__c, OT_ESI__c, Individual_Cost__c, Total_CTC__c, PF_Employee__c, ESI_Employee__c, PT_Employee__c, LWF_Employee__c, Net_Take_Home__c, Position__c FROM Contract_Line_Item__c WHERE Green_Sheet__c=:recid order by name];
    
    
    }
    
    public pagereference save()
    {
    
    update cl;
    return new pagereference('/'+recid);
    }
    
    
     public pagereference cancel()
    {
    
    return new pagereference('/'+recid);
    
    }
}