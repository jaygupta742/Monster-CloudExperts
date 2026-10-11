public class Generate_Foundit_PDF {
    String type;
    public List<wrap> wrp{get;set;}
    List<Foundit_Quote_Pdf__c> selecttemp = new List<Foundit_Quote_Pdf__c>();
    public string parentid{get;set;}
    public string pagename;
    public QuotesN__c Quote{get;set;}
    public List<SelectOption> pdfdoc{get;set;}
    public List<Foundit_Quote_Pdf__c> templa{get;set;}
    public String pdfdoc_val{get;set;}
    public boolean a{get;set;}
    public Boolean showAccessories {get; set;}
    public Boolean showindiachecked {get; set;}
    public Map<String,String> pval{get;set;}
    public Map<String,String> dval{get;set;}
    public Map<String,String> RecontractOptions{get;set;}
    
    public Generate_Foundit_PDF (ApexPages.StandardController controller) {
        a = true;
        Quote = new QuotesN__c();
        parentid = ApexPages.currentPage().getParameters().get('id');
        system.debug('$$$$$$$$$$$$$$$$$ ' + parentid);
        Quote = [SELECT Id, Name, Selling_Country__c, Opportunities__c, Opportunities__r.Id, Approval_Status_Overall__c, Payment_count__c, Quote_Path__c, Quote_Type__c FROM QuotesN__c WHERE Id =: parentid LIMIT 1];
        String j= '%'+Quote.Selling_Country__c+'%';
        type='DOC';
        pval = new Map<String,String>();
        dval = new Map<String,String>();
        wrp = New List<wrap>();
        pdfdoc = new List<SelectOption>();
        
        templa = new List<Foundit_Quote_Pdf__c>([SELECT Id, Name, PDF__c, Location__c FROM Foundit_Quote_Pdf__c WHERE Location__c LIKE: j]);
        For(Foundit_Quote_Pdf__c t : templa){
            wrp.add(New wrap(t));
            pdfdoc.add(new SelectOption(t.Name,t.Name));
            if(t.PDF__c != null)
                pval.put(t.Name,t.PDF__c);
        }

        RecontractOptions = new Map<String, String> ();
        RecontractOptions.put('Service Upgrade Agreement - With Advanced Payment', 'Agreement-With Advanced Payment');
        RecontractOptions.put('Service Upgrade Agreement - With Pending Payment', 'Agreement-With Pending Payment');
    }
    
    
    Public void UpadteOpp(){
        OpportunityN__c opp = new OpportunityN__c();
        opp.id = Quote.Opportunities__c ;
        update opp;
    } 
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('DOC','DOC')); 
        options.add(new SelectOption('PDF','PDF'));
        return options; 
    }
    
    public String gettype() {
        return type;
    }
    
    public void settype(String type) { 
        this.type= type; 
    }
    
    public class wrap{
        public boolean b{get;set;}
        public Foundit_Quote_Pdf__c tmpl{get;set;}
        public wrap(Foundit_Quote_Pdf__c t){
            tmpl = t;
            b = false;
        }
    }
    
    public Pagereference  selectcon(){
        a = false;  
        For(wrap w : wrp){
            system.debug('qqqqqqqqqqqqqqqqq'+wrp);    
            If(w.b){
                system.debug('eeeeeeeeeeeeeeee'+w.b); 
                selecttemp.add(w.tmpl);    
            }
        }
        return null;   
    } 
    
    public pagereference Generate() {
        System.debug('Generate Action running...' + pdfdoc_val);
        
        if (pdfdoc_val == null) {  
            return null;
        }
        string source, fileName;

        if(Quote.Quote_Type__c == 'Recontract') {
            source = 'RecontractAgreement';
            fileName = 'Foundit_RecontractAgreement.pdf';
        } else {
            source = pval.get(pdfdoc_val);
            fileName = source + '.pdf';
        }

        // Construct the URL with all necessary parameters
        pagereference pr = new pagereference('/apex/' + source + '?id=' + parentid + '&showAccessories=' + showAccessories + '&showindiachecked=' + showindiachecked);
        pr.getParameters().put('id', parentid);
        pr.getParameters().put('showAccessories', String.valueOf(showAccessories));
        pr.getParameters().put('showindiachecked', String.valueOf(showindiachecked)); // Add this line
        
        blob body;
        if (!test.isRunningTest()) {
            body = pr.getContent();
        } else {
            body = blob.valueOf('Hi');
        } 
        
        ContentVersion cv = new ContentVersion();
        cv.VersionData = body;
        cv.Title = fileName;
        cv.PathOnClient = fileName;
        cv.FirstPublishLocationId = parentid;
        Insert cv;
        
        Quote.Quote_Path__c = 'Agreement Generated';
        Update Quote;
        
        return pr;
    }
}