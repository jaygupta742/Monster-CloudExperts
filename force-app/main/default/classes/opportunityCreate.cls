public class opportunityCreate {
Public Opportunity__c op{get;set;}
Public Boolean spclPerm{get;set;}
Public Boolean errorMsg{get;set;}
Public Boolean freeTrail{get;set;}
Public Account acc{get;set;}
Public Decimal sum{get;set;}
Public String accID{get;set;}
Public String accOwner{get;set;}
Public String OppId{get;set;}
//Public String Recid{get;set;}
//Public String RecName{get;set;}
Public Map<String,String> DupRec{get;set;}
Public Boolean seeker{get;set;}

    
public boolean creditStatusDisplayMsg{get;set;}    
        
    public opportunityCreate(ApexPages.StandardController controller) {
        
         creditStatusDisplayMsg = false;
         seeker = false;
        
        User us = [select id,name,EmployeeNumber from user where id=:UserInfo.getUserId()];
        
        
        this.op = (Opportunity__c)Controller.getRecord();
        if(userinfo.getProfileId() == System.Label.Seeker_Profile_Id){
            seeker = true;
        }
        accID = ApexPages.currentpage().getParameters().get('accID');
        sum = 0;
        accOwner = ApexPages.currentpage().getParameters().get('accOwner');
        OppId = '';
        errorMsg = false;
        freeTrail = false;
        DupRec = new Map<String,String>();
        OppId = ApexPages.currentpage().getParameters().get('id');
        acc = new Account();
        spclPerm = false;
        if(userinfo.getName() == 'Ajesh Shyam' || userinfo.getName() == 'Cloud Experts Salesforce') spclPerm = true;
        
        if(OppId == null){
        acc = [select id,Lead_Account_Status__c,AccountStatus__c,CreditStatus__c,(select id from contacts where PrimarySalesContact__c = true),(Select id,Name,Name__c,OpportunityType__c,Probability__c from Opportunities__r where (createddate > 2018-10-01T00:00:00z AND OwnerId =:accOwner AND id !=: OppId ) AND (Probability__c = '0' OR Probability__c = '10' OR Probability__c = '25') AND Stage__c != 'Closed Lost') from Account where id =: accID];
       
           if(acc.CreditStatus__c == 'On Hold - Finance' || acc.CreditStatus__c == 'On Hold - Compliance' || acc.CreditStatus__c == 'On Hold - Both' || acc.CreditStatus__c == 'Suspend'){
         
         creditStatusDisplayMsg  = true;
        
        }
            
            /*If(acc.Opportunities__r.size()>0){
            errorMsg = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please work on one of these existing opportunity'));
        }*/
        
        //else{
            op.Account__c = accID;
            if(acc.contacts.size()>0)
            op.Contact__c = acc.contacts[0].id;
            op.Branding_Revenue__c = 0;
            op.Custom_Job_Template_Revenue__c= 0;
            op.Custom_Sponsorship_Revenue__c= 0;
            op.Custom_International_Sponsorship_Reven__c = 0;
            op.Job_Postings_Revenue__c= 0;
            op.Logo_on_Job_Postings_Revenue__c= 0;
            op.Monster_Assessments_Revenue__c= 0;
            op.Monster_Mirror_Revenue__c= 0;
            op.Monster_Widget_Revenue__c= 0;
            op.Premium_Resume_Search_Revenue__c= 0;
            op.Promotional_Offer_Revenue__c= 0;
            op.Short_Message_Service_Revenue__c= 0;
            op.QHire_Revenue__c= 0;
            op.Social_Job_Ads_Revenue__c= 0;
            op.TalentBin_by_Monster_Revenue__c= 0;
            op.Target_Mailers_Revenue__c= 0;
            op.Walk_in_Pro_Event_Revenue__c= 0;
            op.Owner_Emp_Id__c = us.EmployeeNumber;
            // B2C/Seeker
            op.Resume_Highlighter_Revenue__c= 0;
            op.Express_Resume_Revenue__c= 0;
            op.Cover_Letter_Revenue__c= 0;
            op.Career_Booster_Revenue__c= 0;
            op.Smart_CV_Revenue__c= 0;
            op.Right_Resume_Revenue__c= 0;
            //Seeker/B2C
        //}
        }
        if(acc.Lead_Account_Status__c=='Inactive' && userInfo.getProfileId()!=System.Label.Seeker_Profile_Id){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please activate the account first then try again');
            ApexPages.addMessage(myMsg);
        }
        
        
        
    }
    
    public void sumOfAmount(){
        sum = 0;
        
        if(op.Branding_Revenue__c != null)sum = sum+op.Branding_Revenue__c;
        if(op.Custom_Job_Template_Revenue__c!= null) sum = sum+op.Custom_Job_Template_Revenue__c;
        if(op.Custom_Sponsorship_Revenue__c!= null) sum = sum+op.Custom_Sponsorship_Revenue__c;
        if(op.Custom_International_Sponsorship_Reven__c != null) sum = sum+op.Custom_International_Sponsorship_Reven__c;
        if(op.Job_Postings_Revenue__c!= null) sum = sum+op.Job_Postings_Revenue__c;
        if(op.Logo_on_Job_Postings_Revenue__c!= null) sum = sum+op.Logo_on_Job_Postings_Revenue__c;
        if(op.Monster_Assessments_Revenue__c!= null) sum = sum+op.Monster_Assessments_Revenue__c;
        if(op.Monster_Mirror_Revenue__c!= null) sum = sum+op.Monster_Mirror_Revenue__c;
        if(op.Monster_Widget_Revenue__c!= null) sum = sum+op.Monster_Widget_Revenue__c;
        if(op.Premium_Resume_Search_Revenue__c!= null) sum = sum+op.Premium_Resume_Search_Revenue__c;
        if(op.Promotional_Offer_Revenue__c!= null) sum = sum+op.Promotional_Offer_Revenue__c;
        if(op.Short_Message_Service_Revenue__c!= null) sum = sum+op.Short_Message_Service_Revenue__c;
        if(op.QHire_Revenue__c!= null) sum = sum+op.QHire_Revenue__c;
        if(op.Social_Job_Ads_Revenue__c!= null) sum = sum+op.Social_Job_Ads_Revenue__c;
        if(op.TalentBin_by_Monster_Revenue__c!= null) sum = sum+op.TalentBin_by_Monster_Revenue__c;
        if(op.Target_Mailers_Revenue__c!= null) sum = sum+op.Target_Mailers_Revenue__c;
        if(op.Walk_in_Pro_Event_Revenue__c!= null) sum = sum+op.Walk_in_Pro_Event_Revenue__c;
        //Seeker/B2C
        if(op.Resume_Highlighter_Revenue__c!= null) sum = sum+op.Resume_Highlighter_Revenue__c;
        if(op.Express_Resume_Revenue__c!= null) sum = sum+op.Express_Resume_Revenue__c;
        if(op.Cover_Letter_Revenue__c!= null) sum = sum+op.Cover_Letter_Revenue__c;
        if(op.Career_Booster_Revenue__c!= null) sum = sum+op.Career_Booster_Revenue__c;
        if(op.Smart_CV_Revenue__c!= null) sum = sum+op.Smart_CV_Revenue__c;
        if(op.Right_Resume_Revenue__c!= null) sum = sum+op.Right_Resume_Revenue__c;
        //Seeker/B2C
        op.Amount__c = sum;
    }
    
    Public Pagereference save(){
    
    errorMsg = false;
    freeTrail = false;
    DupRec =  new Map<String,String>();
       //system.debug('acc'+acc.Account_Status__c);
        //Nag
        system.debug('Opportunity type----------->'+op.OpportunityType__c);
        system.debug('Opportunity\'s Account Status----------->'+acc.AccountStatus__c);
        if(op.OpportunityType__c == null){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Select appropriate Opportunity Type')); 
           return null;
        }
        //@YAm added from here 
        //candidate accounts 
         if((!(op.OpportunityType__c == 'Free Trial' ||op.OpportunityType__c == 'New Customer'))&&(acc.AccountStatus__c == 'Lead'||acc.AccountStatus__c =='Candidate')){
            system.debug('asgf'+op.OpportunityType__c);
           system.debug('Opportunity\'s Account Status----------->'+acc.AccountStatus__c);
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please choose Free Trial or New customer if Account status is Lead or Candidate')); 
           return null;
        }
        // for lapsed accounts @yam //op.OpportunityType__c == 'Renewal'||op.OpportunityType__c == 'Upsell'||acc.AccountStatus__c == 'Customer'||
         if((!(op.OpportunityType__c == 'Free Trial' ||op.OpportunityType__c == 'Lapsed'))&&(acc.AccountStatus__c =='Lapsed Customer')){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please choose opportunity type as Free Trial or Lapsed if Account status is Lapsed Customer')); 
           return null;
        } 
        //for customers 
         if((!(op.OpportunityType__c == 'Free Trial'||op.OpportunityType__c == 'Upsell' ||op.OpportunityType__c == 'Renewal'))&&(acc.AccountStatus__c =='Customer')){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please choose opportunity type as Free Trial,Upsell or Renewal if Account status is Customer')); 
           return null;
        } 
        
        //Nag
        If(acc.Opportunities__r.size()>0){
            for(Opportunity__c opp : acc.Opportunities__r){
                if(opp.OpportunityType__c == op.OpportunityType__c){
                    errorMsg = true;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please work on Existing Opportunity. You can create multiple opportunity only once the existing opportunity is in Stage- Negotiation Complete (50%)'));
                    DupRec.Put(opp.Id,opp.Name);
                   
                }
            }
            If(DupRec.size()>0)
                return null;
        }
        if(op.Opportunity_Lost_deferred__c == true && (op.DispositionReason__c == '' || op.DispositionReason__c == null || op.DispositionReason__c == 'none') ){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter reason for lost value')); 
            //}   
       
        //return new Pagereference('/'+op.id);
        return null;
        }
    
       
        
            
        
        if((op.OpportunityType__c == 'Free Trial' && !seeker) && (op.Products_Interested__c.contains('Branding') ||  op.Products_Interested__c.contains('Custom International Sponsorship')
           || op.Products_Interested__c.contains('Custom Job Template') || op.Products_Interested__c.contains('Custom Sponsorship') || (op.Products_Interested__c.contains('Job Postings') && op.Products_Interested__c.contains('Trail-Job Postings'))
           || op.Products_Interested__c.contains('Logo on Job Postings') || op.Products_Interested__c.contains('Monster Mirror') || op.Products_Interested__c.contains('Monster Widget')
           || op.Products_Interested__c.contains('Premium Resume Search') || op.Products_Interested__c.contains('Short Message Service') || op.Products_Interested__c.contains('Social Job Ads')
           || op.Products_Interested__c.contains('TalentBin by Monster') || op.Products_Interested__c.contains('Target Mailers') || op.Products_Interested__c.contains('Walk-in-Pro Event')
           || op.Products_Interested__c.contains('Monster Assessments') || op.Products_Interested__c.contains('QHire') )){
           
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'You cannot add paid products for free trail'));
           errorMsg = true;
           freeTrail= true;
           op.Branding_Revenue__c = 0;
            op.Custom_Job_Template_Revenue__c= 0;
            op.Custom_Sponsorship_Revenue__c= 0;
            op.Custom_International_Sponsorship_Reven__c = 0;
            op.Job_Postings_Revenue__c= 0;
            op.Logo_on_Job_Postings_Revenue__c= 0;
            op.Monster_Assessments_Revenue__c= 0;
            op.Monster_Mirror_Revenue__c= 0;
            op.Monster_Widget_Revenue__c= 0;
            op.Premium_Resume_Search_Revenue__c= 0;
            op.Promotional_Offer_Revenue__c= 0;
            op.Short_Message_Service_Revenue__c= 0;
            op.QHire_Revenue__c= 0;
            op.Social_Job_Ads_Revenue__c= 0;
            op.TalentBin_by_Monster_Revenue__c= 0;
            op.Target_Mailers_Revenue__c= 0;
            op.Walk_in_Pro_Event_Revenue__c= 0;
            
           system.debug('I am Inside '+op.OpportunityType__c);
           system.debug('I am II'+op.Products_Interested__c);
           return null;
        }
        
        /*if(seeker && ( op.Products_Interested_B2C__c.contains('Resume Highlighter') || op.Products_Interested_B2C__c.contains('Express Resume') || op.Products_Interested_B2C__c.contains('Cover Letter') || op.Products_Interested_B2C__c.contains('Career Booster')
                      || op.Products_Interested_B2C__c.contains('Smart CV') || op.Products_Interested_B2C__c.contains('Right Resume'))){
            //Seeker/B2C
            op.Resume_Highlighter_Revenue__c= 0;
            op.Express_Resume_Revenue__c= 0;
            op.Cover_Letter_Revenue__c= 0;
            op.Career_Booster_Revenue__c= 0;
            op.Smart_CV_Revenue__c= 0;
            op.Right_Resume_Revenue__c= 0;
            //Seeker/B2C
           system.debug('I am Inside '+op.OpportunityType__c);
           system.debug('I am II'+op.Products_Interested__c);
        }*/
    
        if((!errorMsg)){
        sum = 0;
        if(!seeker){
        if(op.Products_Interested__c.contains('Branding')&&op.Branding_Revenue__c == 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Branding Revenue Value more than 0'));
            return null;
        }
        else if(op.Branding_Revenue__c != null && op.Products_Interested__c.contains('Branding')){sum = sum+op.Branding_Revenue__c;}
        system.debug('sum1-->'+sum);
        if(op.Products_Interested__c.contains('Custom International Sponsorship')&&op.Custom_International_Sponsorship_Reven__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Custom International Sponsorship Revenue Value more than 0'));
            return null;
        }
        else if(op.Custom_International_Sponsorship_Reven__c!= null && op.Products_Interested__c.contains('Custom International Sponsorship')){sum = sum+op.Custom_International_Sponsorship_Reven__c;}
        system.debug('sum2-->'+sum);
        if(op.Products_Interested__c.contains('Custom Job Template')&&op.Custom_Job_Template_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Custom Job Template Revenue Value more than 0'));
            return null;
        }
        else if(op.Custom_Job_Template_Revenue__c!= null && op.Products_Interested__c.contains('Custom Job Template')){sum = sum+op.Custom_Job_Template_Revenue__c;}
        system.debug('sum3-->'+sum);
        if(op.Products_Interested__c.contains('Custom Sponsorship')&&op.Custom_Sponsorship_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Custom Sponsorship Revenue Value more than 0'));
            return null;
        }
        else if(op.Custom_Sponsorship_Revenue__c!= null && op.Products_Interested__c.contains('Custom Sponsorship')){sum = sum+op.Custom_Sponsorship_Revenue__c;}
        system.debug('sum4-->'+sum);
        if(op.Products_Interested__c.contains('Job Postings')&&op.Products_Interested__c.contains('Trail-Job Postings')&&op.Job_Postings_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Job Postings Revenue Value more than 0'));return null;}
        else if(op.Job_Postings_Revenue__c!= null && op.Products_Interested__c.contains('Job Postings')){sum = sum+op.Job_Postings_Revenue__c;
                                                  } system.debug('sum5-->'+sum);
        if(op.Products_Interested__c.contains('Logo on Job Postings')&&op.Logo_on_Job_Postings_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Logo on Job Postings Revenue Value more than 0'));
            return null;
        }
        else if(op.Logo_on_Job_Postings_Revenue__c!= null && op.Products_Interested__c.contains('Logo on Job Postings')){sum = sum+op.Logo_on_Job_Postings_Revenue__c;}
        system.debug('sum6-->'+sum);
        if(op.Products_Interested__c.contains('Monster Mirror')&&op.Monster_Mirror_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Monster Mirror Revenue Value more than 0'));
            return null;
        }
        else if(op.Monster_Mirror_Revenue__c!= null && op.Products_Interested__c.contains('Monster Mirror')){sum = sum+op.Monster_Mirror_Revenue__c;}
        system.debug('sum7-->'+sum);
        if(op.Products_Interested__c.contains('Monster Widget')&&op.Monster_Widget_Revenue__c == 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Monster Widget Revenue Value more than 0'));
            return null;
        }
        else if(op.Monster_Widget_Revenue__c != null && op.Products_Interested__c.contains('Monster Widget')){sum = sum+op.Monster_Widget_Revenue__c ;}
        system.debug('sum8-->'+sum);
        if(op.Products_Interested__c.contains('Premium Resume Search')&&op.Premium_Resume_Search_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Premium Resume Search Revenue Value more than 0'));
            return null;
        }
        else if(op.Premium_Resume_Search_Revenue__c!= null && op.Products_Interested__c.contains('Premium Resume Search')){sum = sum+op.Premium_Resume_Search_Revenue__c;}
        system.debug('sum9-->'+sum);
        if(op.Products_Interested__c.contains('Promotional Offer')&&op.Promotional_Offer_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Promotional Offer Revenue Value more than 0'));
            return null;
        }
        else if(op.Promotional_Offer_Revenue__c!= null && op.Products_Interested__c.contains('Promotional Offer')){sum = sum+op.Promotional_Offer_Revenue__c;}system.debug('sum10-->'+sum);
        if(op.Products_Interested__c.contains('Short Message Service')&&op.Short_Message_Service_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Short Message Service Revenue Value more than 0'));
            return null;
        }
        else if(op.Short_Message_Service_Revenue__c!= null && op.Products_Interested__c.contains('Short Message Service')){sum = sum+op.Short_Message_Service_Revenue__c;}system.debug('sum11-->'+sum);
        
        if(op.Products_Interested__c.contains('Social Job Ads')&&op.Social_Job_Ads_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Social Job Ads Revenue Value more than 0'));
            return null;
        }
        else if(op.Social_Job_Ads_Revenue__c!= null && op.Products_Interested__c.contains('Social Job Ads')){sum = sum+op.Social_Job_Ads_Revenue__c;}system.debug('sum12-->'+sum);
       
        if(op.Products_Interested__c.contains('TalentBin by Monster')&&op.TalentBin_by_Monster_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter TalentBin by Monster Revenue Value more than 0'));
            return null;
        }
        else if(op.TalentBin_by_Monster_Revenue__c!= null && op.Products_Interested__c.contains('TalentBin by Monster')){sum = sum+op.TalentBin_by_Monster_Revenue__c;}system.debug('sum13-->'+sum);
        if(op.Products_Interested__c.contains('Target Mailers')&&op.Target_Mailers_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Walk-in-Pro Event Revenue Value more than 0'));
            return null;
        }
        else if(op.Target_Mailers_Revenue__c!= null && op.Products_Interested__c.contains('Target Mailers')){sum = sum+op.TalentBin_by_Monster_Revenue__c;}system.debug('sum14-->'+sum);
       
        if(op.Products_Interested__c.contains('Target Mailers')&&op.Target_Mailers_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Walk-in-Pro Event Revenue Value more than 0'));
            return null;
        }
        
        else if(op.Quinton_Revenue__c!= null && op.Products_Interested__c.contains('Quinton')){sum = sum+op.Quinton_Revenue__c;}system.debug('sum15-->'+sum);
        if(op.Products_Interested__c.contains('Quinton')&&op.Quinton_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Quinton Revenue Value more than 0'));
            return null;
        }
        
        else if(op.Target_Mailers_Revenue__c!= null && op.Products_Interested__c.contains('Target Mailers')){sum = sum+op.Target_Mailers_Revenue__c;}system.debug('sum16-->'+sum);
        if(op.Products_Interested__c.contains('Walk-in-Pro Event')&&op.Walk_in_Pro_Event_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Branding Revenue Value more than 0'));
            return null;
        }
        else if(op.Walk_in_Pro_Event_Revenue__c!= null && op.Products_Interested__c.contains('Walk-in-Pro Event')){sum = sum+op.Walk_in_Pro_Event_Revenue__c;}system.debug('sum17-->'+sum);
       
        if(op.Products_Interested__c.contains('Monster Assessments')&&op.Monster_Assessments_Revenue__c == 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Monster Assessments Revenue Value more than 0'));
            return null;
        }
        else if(op.Monster_Assessments_Revenue__c != null && op.Products_Interested__c.contains('Monster Assessments')){sum = sum+op.Monster_Assessments_Revenue__c ;}system.debug('sum18-->'+sum);
        if(op.Products_Interested__c.contains('QHire')&&op.QHire_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter QHire Revenue Value more than 0'));
            return null;
        }
        else if(op.QHire_Revenue__c!= null && op.Products_Interested__c.contains('QHire')){sum = sum+op.QHire_Revenue__c;}system.debug('sum19-->'+sum);
        
        if(sum == 0&&op.OpportunityType__c != 'Free Trial'){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please choose any paid product if Opportunity type is not FREE TRAIL'));
        return null;
        }
        }
        if(seeker ){
        //B2C/Seeker
        if(op.Products_Interested_B2C__c.contains('Resume Highlighter')&&op.Resume_Highlighter_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Resume Highlighter Revenue Value more than 0'));
            return null;
        }
        else if(op.Resume_Highlighter_Revenue__c!= null && op.Products_Interested_B2C__c.contains('Resume Highlighter')){sum = sum+op.Resume_Highlighter_Revenue__c;}system.debug('sum19-->'+sum);
        if(op.Products_Interested_B2C__c.contains('Express Resume')&&op.Express_Resume_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Express Resume Revenue Value more than 0'));
            return null;
        }
        else if(op.Express_Resume_Revenue__c!= null && op.Products_Interested_B2C__c.contains('Express Resume')){sum = sum+op.Express_Resume_Revenue__c;}system.debug('sum19-->'+sum);
        if(op.Products_Interested_B2C__c.contains('Career Booster')&&op.Career_Booster_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Career Booster Revenue Value more than 0'));
            return null;
        }
        else if(op.Career_Booster_Revenue__c!= null && op.Products_Interested_B2C__c.contains('Career Booster')){sum = sum+op.Career_Booster_Revenue__c;}system.debug('sum19-->'+sum);
        if(op.Products_Interested_B2C__c.contains('Cover Letter')&&op.Cover_Letter_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Cover Letter Revenue Value more than 0'));
            return null;
        }
        else if(op.Cover_Letter_Revenue__c!= null && op.Products_Interested_B2C__c.contains('Cover Letter')){sum = sum+op.Cover_Letter_Revenue__c;}system.debug('sum19-->'+sum);
        if(op.Products_Interested_B2C__c.contains('Smart CV')&&op.Smart_CV_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Smart CV Revenue Value more than 0'));
            return null;
        }
        else if(op.Smart_CV_Revenue__c!= null && op.Products_Interested_B2C__c.contains('Smart CV')){sum = sum+op.Smart_CV_Revenue__c;}system.debug('sum19-->'+sum);
        if(op.Products_Interested_B2C__c.contains('Right Resume')&&op.Right_Resume_Revenue__c== 0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please enter Right Resume Revenue Value more than 0'));
            return null;
        }
        else if(op.Right_Resume_Revenue__c!= null && op.Products_Interested_B2C__c.contains('Right Resume')){sum = sum+op.Right_Resume_Revenue__c;}system.debug('sum19-->'+sum);
        }
        //B2C/Seeker
        
         system.debug('sum20-->'+sum);
         if(!seeker){
  if(op.Branding_Revenue__c != null && !(op.Products_Interested__c.contains('Branding'))){op.Branding_Revenue__c = 0;}
  if(op.Custom_International_Sponsorship_Reven__c!= null && !(op.Products_Interested__c.contains('Custom International Sponsorship'))){op.Custom_International_Sponsorship_Reven__c =0;}
  if(op.Custom_Job_Template_Revenue__c!= null && !(op.Products_Interested__c.contains('Custom Job Template'))){op.Custom_Job_Template_Revenue__c = 0;}
  if(op.Custom_Sponsorship_Revenue__c!= null && !(op.Products_Interested__c.contains('Custom Sponsorship'))){op.Custom_Sponsorship_Revenue__c = 0;}
 if(op.Job_Postings_Revenue__c!= null && !(op.Products_Interested__c.contains('Job Postings'))){op.Job_Postings_Revenue__c = 0;}
 if(op.Logo_on_Job_Postings_Revenue__c!= null && !(op.Products_Interested__c.contains('Logo on Job Postings'))){op.Logo_on_Job_Postings_Revenue__c =0;}
 if(op.Monster_Mirror_Revenue__c!= null && !(op.Products_Interested__c.contains('Monster Mirror'))){op.Monster_Mirror_Revenue__c =0;}
 if(op.Monster_Widget_Revenue__c != null && !(op.Products_Interested__c.contains('Monster Widget'))){op.Monster_Widget_Revenue__c=0 ;}
 if(op.Premium_Resume_Search_Revenue__c!= null && !(op.Products_Interested__c.contains('Premium Resume Search'))){op.Premium_Resume_Search_Revenue__c=0;}
 if(op.Promotional_Offer_Revenue__c!= null && !(op.Products_Interested__c.contains('Promotional Offer'))){op.Promotional_Offer_Revenue__c=0;}
 if(op.Short_Message_Service_Revenue__c!= null && !(op.Products_Interested__c.contains('Short Message Service'))){op.Short_Message_Service_Revenue__c=0;}
 if(op.Social_Job_Ads_Revenue__c!= null && !(op.Products_Interested__c.contains('Social Job Ads'))){op.Social_Job_Ads_Revenue__c=0;}
 if(op.TalentBin_by_Monster_Revenue__c!= null && !(op.Products_Interested__c.contains('TalentBin by Monster'))){op.TalentBin_by_Monster_Revenue__c=0;}
  if(op.Target_Mailers_Revenue__c!= null && !(op.Products_Interested__c.contains('Target Mailers'))){op.Target_Mailers_Revenue__c=0;}
  if(op.Quinton_Revenue__c!= null && !(op.Products_Interested__c.contains('Quinton'))){op.Quinton_Revenue__c=0;}
 if(op.Target_Mailers_Revenue__c!= null && !(op.Products_Interested__c.contains('Target Mailers'))){op.Target_Mailers_Revenue__c=0;}
  if(op.Walk_in_Pro_Event_Revenue__c!= null && !(op.Products_Interested__c.contains('Walk-in-Pro Event'))){op.Walk_in_Pro_Event_Revenue__c=0;}
   if(op.Monster_Assessments_Revenue__c != null && !(op.Products_Interested__c.contains('Monster Assessments'))){op.Monster_Assessments_Revenue__c =0;}
    if(op.QHire_Revenue__c!= null && !(op.Products_Interested__c.contains('QHire'))){op.QHire_Revenue__c=0;}
    }
    //B2C/Seeker
    if(seeker ){
    if(op.Resume_Highlighter_Revenue__c!= null && !(op.Products_Interested_B2C__c.contains('Resume Highlighter'))){op.Resume_Highlighter_Revenue__c=0;}
    if(op.Express_Resume_Revenue__c!= null && !(op.Products_Interested_B2C__c.contains('Express Resume'))){op.Express_Resume_Revenue__c=0;}
    if(op.Cover_Letter_Revenue__c!= null && !(op.Products_Interested_B2C__c.contains('Career Booster'))){op.Cover_Letter_Revenue__c=0;}
    if(op.Career_Booster_Revenue__c!= null && !(op.Products_Interested_B2C__c.contains('Cover Letter'))){op.Career_Booster_Revenue__c=0;}
    if(op.Smart_CV_Revenue__c!= null && !(op.Products_Interested_B2C__c.contains('Smart CV'))){op.Smart_CV_Revenue__c=0;}
    if(op.Right_Resume_Revenue__c!= null && !(op.Products_Interested_B2C__c.contains('Right Resume'))){op.Right_Resume_Revenue__c=0;}
    }
    //B2C/Seeker
         
        op.Amount__c = sum;
        Upsert op;
        return new Pagereference('/'+op.id);
        }
        return null;
    }
}