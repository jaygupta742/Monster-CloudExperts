public class GeneratePdf {
    String type;
    Public List<wrap> wrp{get;set;}
    list<New_Template1__c> selecttemp = new list<New_Template1__c>();
    public string parentid{get;set;}
    public string pagename;
    Public QuotesN__c hh{get;set;}
    public List<SelectOption> pdfdoc{get;set;}
    Public List<New_Template1__c> templa{get;set;}
    Public String pdfdoc_val{get;set;}
    public boolean a{get;set;}
    Public Map<String,String> pval{get;set;}
    Public Map<String,String> dval{get;set;}
    
    public GeneratePdf (ApexPages.StandardController controller) {
        a = true;
        hh = new QuotesN__c();
        parentid = ApexPages.currentPage().getParameters().get('id');
        hh=[select id,name,Selling_Country__c,Opportunities__c from QuotesN__c where id=:parentid limit 1];
        String j= '%'+hh.Selling_Country__c+'%';
        type='DOC';
        pval = new Map<String,String>();
        dval = new Map<String,String>();
        wrp = New List<wrap>();
        pdfdoc = new List<SelectOption>();
        
        templa = new List<New_Template1__c>([Select ID , Name,PDF__c,Location__c From New_Template1__c where Location__c like:j]);
        For(New_Template1__c t : templa){
            
            wrp.add(New wrap(t));
            pdfdoc.add(new SelectOption(t.Name,t.Name));
            if(t.PDF__c != null)
                pval.put(t.Name,t.PDF__c);
            //if(t.DOC__c != null)
              //  dval.put(t.Name,t.DOC__c);
        }
    }
    
    
    Public void UpadteOpp(){
        OpportunityN__c opp = new OpportunityN__c();
        opp.id = hh.Opportunities__c ;
        //opp.Stage__c = 'Negotiation Complete';   -- Nag(Opp enhancement)
        //opp.Probability__c = '50';
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
    
    /*Public List<wrap> gettemps(){


For(New_Template1__c t : [Select ID , Name,PDF__c,DOC__c ,Location__c From Template__c]){

wrp.add(New wrap(t));

}
system.debug('complete list:'+wrp);
return wrp;
}*/
    
    
    public class wrap{
        
        
        public boolean b{get;set;}
        public New_Template1__c tmpl{get;set;}
        
        public wrap(New_Template1__c t){
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
    
    
    public pagereference Generate(){
        
        
        
        if(pdfdoc_val==null)
        {
            
            return null;
        }
        
        
        string source;
        
        // if(type == 'PDF'){
        
        source = pval.get(pdfdoc_val);
        pagereference pr = new pagereference('/apex/'+source+'?id='+parentid);
        pr.getParameters().put('id',parentid);
        pr.setRedirect(true);
        blob body;
        if(!test.isRunningTest())
            body = pr.getContentAsPDF();
        else 
            body = blob.valueOf('Hi');
        string filename = source+'.pdf';
        
        attachment theFile = new attachment();
        theFile.body = body;
        theFile.Name = filename;
        theFile.ParentId = parentid;
        insert theFile;
        
        return pr;
        // }
        //  return null;
    }
    
    /*for(wrap j:wrp)

{  system.debug('wwwwwwwwwwwwwww'+wrp);
string source;
// if(j.b==true)
// {    

if(type == 'DOC'){
source=j.tmpl.DOC__c;
pagereference pr = new pagereference('/apex/'+source+'?id='+parentid);
return pr;
}
Else If(type == 'PDF'){
source=j.tmpl.PDF__c;
pagereference pg = new pagereference('/apex/'+source+'?id='+parentid);
return pg;
}
system.debug('dddddddddddddd'+j.b);    
//}
}
Return Null;
}*/
    
}