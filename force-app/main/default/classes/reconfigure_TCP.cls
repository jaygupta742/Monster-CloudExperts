public class reconfigure_TCP {
Public String currencytype{get;set;} 
Public decimal amount{get;set;}
public string qlid=ApexPages.currentpage().getParameters().get('id');
Public List<String> pop{get;set;}
Public List<Selectoption> temp{get;set;}
Public List<AttWrap> law{get;set;}
Public boolean price{get;set;}
Public boolean cshow{get;set;}
Public Product_Attribute__c ppa{get;set;}
Public string paid{get;set;}
string source=ApexPages.currentpage().getParameters().get('source');
Public  Proposal_Line_Item__c hh{get;set;}
Public decimal amount1{get;set;}
  string congif;
  Public  decimal quantity{get;set;}
    public reconfigure_TCP()
    { law = new List<AttWrap>();
     ppa = new Product_Attribute__c();
        hh=  [SELECT Id, Name, APTS_Extended_List_Price__c,Product_Name__c,Product_Details__c  ,APTS_Attribute_Display__c, APTTS_Tax_Amount__c, APTTS_Tax_Rate__c, Proposal_Locked__c,Proposal_Locked__r.PriceList__c, StateProvinceTaxRate__c, TotalStateProvinceTaxAmount__c, Product__c, Quantity__c, Adjustment_Amount__c, Adjustment_Type__c, End_Date__c, Price__c, Start_Date__c, Status__c, Discount_Amount__c, Price_After_Discount__c, Gross_Total__c, Total_Discount__c, Base_Total__c FROM Proposal_Line_Item__c WHERE Id =:qlid limit 1];
     quantity=hh.quantity__c;
     amount1=hh.Price__c;
     
     ppa = [select Attributes__c from Product_Attribute__c where Product__c = :hh.Product__c limit 1];
        string ppav = ppa.Attributes__c;
        pop = new List<String>();
        pop.Addall(ppav.split(';'));
    
     string pav=hh.APTS_Attribute_Display__c;
     congif=pav;
    List<String> op = new List<String>();
        op.Addall(pav.split(';'));
        System.debug('Val: '+op);
        
        Map<String,List<String>> fmap = new Map<String,List<String>>();
        Map<String,Integer> seqmap = new Map<String,Integer>();
        for(String s : op){
            List<string> value = new List<String>();
            string values;
            String field;
            //integer seq;
            //seq = Integer.valueof(s.substringAfter(':'));
            //values = s.substringBetween('=',':');
            values = s.substringAfter('=');
            field = s.substringBefore('=');
            value.Addall(values.split(','));
            fmap.put(field,value);
            //seqmap.put(field,seq);
        }
        System.debug(fmap);
        for(String s : fmap.keyset()){
            if(pop.contains(s)){
                integer seq;
                temp = new List<Selectoption>();
                for(String s1 : fmap.get(s)){
                    temp.add(new SelectOption(s1,s1));
                }
                seq = seqmap.get(s);
                system.debug('1:'+temp);
                law.add(new AttWrap(s,temp,seq));
                system.debug('3:'+s);
            }
        }
        if(ppav.contains('Final')){
            price = false;
        }
    
    
    
    }
    
    
    
     Public pagereference chk(){
        
        price = false;
        
        if(law.size()>0){
            for(AttWrap ss : law){
                if(ss.socv == 'None'){
                    price = true;
                }
             }
         }
        
        return null;
    }
    
     Public class AttWrap{
        Public String sol{get;set;}
        Public List<Selectoption> sov{get;set;}
        Public String socv{get;set;}
        Public Boolean show{get;set;}
        public integer seqnum{get;set;}
        Public AttWrap(String label,List<Selectoption> values,Integer seq1){
            sov = new List<Selectoption>();
            sol = label;
            if(values.size()>1)sov.add(new SelectOption('None','None'));
            sov.addall(values);
            seqnum = seq1;
            if(sov.size()>1)show = false;
            else if(sov.size()==1){show = true;socv = sov[0].getValue();}
            
        }
    }
    
    
    
     Public void Configure_Product_Attribute (){
        price = true;
        cshow = false;
        ppa = new Product_Attribute__c();
        law = new List<AttWrap>();
        
        ppa = [select Attributes__c from Product_Attribute__c where Product__c = :hh.Product__c  limit 1];
        string ppav = ppa.Attributes__c;
        pop = new List<String>();
        pop.Addall(ppav.split(';'));
        
        String qs;
        if(law.size()>0){
            qs = 'Product:';
            for(AttWrap ss : law){
                if(ss.socv != ''){
                    qs = ss.sol+'=';
                    qs = qs+ss.socv;
                    qs = qs+';';
                    system.debug('Query String'+qs);
                }    
            }
            system.debug('Query String Final'+qs);
        }
        
        if(qs == null || qs == '')qs = 'Product:Start;';
        system.debug('Null: '+qs);
        Product_Attribute_Value__c pa = new Product_Attribute_Value__c();
        pa = [select Set__c,get__c from Product_Attribute_Value__c where Product__c = :hh.Product__c   and Get__c = :qs and Product_PriceList__c=:hh.Proposal_Locked__r.PriceList__c limit 1];
        string pav = pa.Set__c;
           congif=pa.Set__c;
        List<String> op = new List<String>();
        op.Addall(pav.split(';'));
        System.debug('Val: '+op);
        
        Map<String,List<String>> fmap = new Map<String,List<String>>();
        Map<String,Integer> seqmap = new Map<String,Integer>();
        for(String s : op){
            List<string> value = new List<String>();
            string values;
            String field;
            //integer seq;
            //seq = Integer.valueof(s.substringAfter(':'));
            //values = s.substringBetween('=',':');
            values = s.substringAfter('=');
            field = s.substringBefore('=');
            value.Addall(values.split(','));
            fmap.put(field,value);
            //seqmap.put(field,seq);
        }
        System.debug(fmap);
        for(String s : fmap.keyset()){
            if(pop.contains(s)){
                integer seq;
                temp = new List<Selectoption>();
                for(String s1 : fmap.get(s)){
                    temp.add(new SelectOption(s1,s1));
                }
                seq = seqmap.get(s);
                system.debug('1:'+temp);
                law.add(new AttWrap(s,temp,seq));
                system.debug('3:'+s);
            }
        }
        if(pa.Set__c.contains('Final')){
            price = false;
        }
    }
    
    
    
    
    
    
   /* Public pagereference configchange(){
        
        String qs;
        if(law.size()>0){
            //qs = 'Product:';
            for(AttWrap ss : law){
                if(ss.socv != ''){
                    if(qs==null)
                    qs = ss.sol+'=';
                    else
                    qs = qs+ss.sol+'=';
                    
                    qs = qs+ss.socv;
                    qs = qs+';';
                    system.debug('Query String'+qs);
                }    
            }
            system.debug('Query String Final'+qs);
        }
        law = new List<AttWrap>();
        if(qs == null || qs == '')qs = 'Product:Start;';
        system.debug('Null: '+qs);
        Product_Attribute_Value__c pa = new Product_Attribute_Value__c();
        
        try{
            pa = [select Set__c,Get__c  from Product_Attribute_Value__c where Product__c = :hh.Product__c  and Get__c = :qs and Product_PriceList__c=: hh.Proposal_Locked__r.PriceList__c limit 1];
            paid = pa.id;
            congif=pa.Set__c;
        }
        catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,qs+':E:'+e));
                return null;
            }
        
        
        string pav = pa.Set__c;
        List<String> op = new List<String>();
        op.Addall(pav.split(';'));
        if(op.contains('Final'))
            price = false;
        System.debug('Val: '+op);
        
        Map<String,List<String>> fmap = new Map<String,List<String>>();
        Map<String,Integer> seqmap = new Map<String,Integer>();
        for(String s : op){
            List<string> value = new List<String>();
            string values;
            String field;
            //integer seq;
            //seq = Integer.valueof(s.substringAfter(':'));
            //values = s.substringBetween('=',':');
            values = s.substringAfter('=');
            field = s.substringBefore('=');
            value.Addall(values.split(','));
            fmap.put(field,value);
            //seqmap.put(field,seq);
        }
        System.debug(fmap);
        for(String s : fmap.keyset()){
            if(pop.contains(s)){
                integer seq;
                temp = new List<Selectoption>();
                for(String s1 : fmap.get(s)){
                    temp.add(new SelectOption(s1,s1));
                }
                seq = seqmap.get(s);
                system.debug('1:'+temp);
                law.add(new AttWrap(s,temp,seq));
                system.debug('3:'+s);
            }
        }
        if(pa.Set__c.contains('Final')){
            price = false;
        }
        return null;
    }*/
    
    
    
    Public pagereference Get_Price_TCP(){
        String qs;
        Product_Price_Entry__c pr = new Product_Price_Entry__c();
        Product_Price_Metrix__c prm = new Product_Price_Metrix__c();
        if(law.size()>0){
            //qs = 'Product:';
            for(AttWrap ss : law){
                if(ss.socv != ''){
                    if(qs==null)
                    qs = ss.sol+'=';
                    else
                    qs = qs+ss.sol+'=';
                    
                    qs = qs+ss.socv;
                    qs = qs+';';
                    system.debug('Query String'+qs);
                }    
            }
            system.debug('Query String Final'+qs);
        }
            system.debug('Price Query String'+qs);
          //  system.debug('ts'+toselect+'pl'+pbid);
            try{
            pr = [SELECT Id, Name, Product__c, PriceList__c FROM Product_Price_Entry__c Where Product__c =: hh.Product__c and PriceList__c =:hh.Proposal_Locked__r.PriceList__c limit 1];
            system.debug('prid'+pr.id);
            prm = [SELECT Id, Name, Product_Price_Entry__c, Product_Config_Code__c, Currency__c, Max__c, Min__c,Product_Price_Entry__r.PriceList__r.Name FROM Product_Price_Metrix__c where Product_Price_Entry__c=:pr.id /*and Product_Config_Code__c=:qs and Min__c<=:quantity and Max__c>=:quantity*/ limit 1];
            }
            catch(Exception e){
               // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,qs+' :E: '+e+' prid '+pr.id+' pbid '+pbid+' toselect '+toselect));
                return null;
            }
            currencytype = prm.Product_Price_Entry__r.PriceList__r.Name;
            amount= prm.Currency__c;
            cshow = true;
              congif=qs;
            return null;
         
    }
    
    
    
    public pagereference Add_to_cart()
 {
 hh.Quantity__c=quantity;

hh.price__C=amount1;
hh.APTS_Attribute_Display__c=congif;
update hh;
 
 

pagereference pf= new pagereference('/apex/'+source+'?id='+hh.Proposal_Locked__c);

 
 return pf;
 }
 
  public pagereference cancelling()
 {
    pagereference pf= new pagereference('/apex/'+source+'?id='+hh.Proposal_Locked__c);

 
 return pf;}


}