public class Add_product1 {
public List<ProductM__c> AvailableProducts {get;set;}
Public boolean price{get;set;}
Public decimal amount{get;set;}
Public decimal amount1{get;set;}
Public boolean cshow{get;set;}
Public boolean soc{get;set;}
Public boolean TCP{get;set;}
Public boolean APPL{get;set;}
Public  String toSelect{get;set;} 
Public  decimal quantity{get;set;}
public list<wrap> ww{get;set;}
Public id pbid{get;set;}
Public string paid{get;set;}
Public String TypeOfQuery{get;set;}
Public id qid{get;set;}
Public String pmmid{get;set;}
/*Product Attribute*/
Public String debug{get;set;}
Public String currencytype{get;set;}
Public  Proposal_Line_Item__c h{get;set;} 
Public List<Selectoption> temp{get;set;}
Public List<Selectoption> state1{get;set;}
Public List<Selectoption> state2{get;set;}
Public List<Selectoption> state3{get;set;}
Public List<Selectoption> city1{get;set;}
Public List<Selectoption> city2{get;set;}
Public List<Selectoption> stateorcity{get;set;}
Public String stateorcity_val{get;set;}
Public Product_Attribute__c ppa{get;set;}
Public List<String> pop{get;set;}
Public List<AttWrap> law{get;set;}
Public String pbkey{get;set;}
public string congif;
//Public Decimal Amount{get;set;}
/*Product Attribute*/
public Product_PriceList__c plist{get;set;}

    public Add_product1()
    {
        h=new Proposal_Line_Item__c();

    }
    
    public void abc()
    {
           pbid = ApexPages.currentpage().getParameters().get('pbid');
             qid = ApexPages.currentpage().getParameters().get('qid');
             TypeOfQuery = ApexPages.currentpage().getParameters().get('toq');
             ww=new list<wrap>();  
             
             plist=[select id,name from Product_PriceList__c where id=:pbid];      
                           String j= '%'+plist.name+'%';
                           String qstring;
                           qstring = 'Select id,Name,Quantity__c,NAPPL__c,Trail_Custom_or_Promo__c From ProductM__c where Active__c=true and Price_List1__c like:j';
                           If(TypeOfQuery == '1')
                               qstring = 'Select id,Name,Quantity__c,NAPPL__c,Trail_Custom_or_Promo__c From ProductM__c where Active__c=true and Seeker_Products__c=true and Price_List1__c like:j';
                           else If(TypeOfQuery == '2')
                               qstring = 'Select id,Name,Quantity__c,NAPPL__c,Trail_Custom_or_Promo__c From ProductM__c where Active__c=true and Seeker_Products__c=false and Price_List1__c like:j';
                           Else If(TypeOfQuery == '3')
                               qstring = 'Select id,Name,Quantity__c,NAPPL__c,Trail_Custom_or_Promo__c From ProductM__c where Active__c=true and Ecomm__c=true and Price_List1__c like:j';
                     List<ProductM__c> lp = new List<ProductM__c>();
                     lp = Database.query(qstring);
                     for(ProductM__c p : lp){
                       
                      ww.add(new wrap(p));
                        }



        }

public class wrap{
public boolean b{get;set;}
public ProductM__c p{get;set;}

    public wrap(ProductM__c g)
    {
    	p=g;
    	b=false;
    }
}

public pagereference configure()
{
TCP = false;
integer i=0;
    for(wrap j:ww)
    {
    if(j.b==true)
    {
        toSelect=j.p.id;
        h.Product_Name__c = j.p.Name;
        if(j.p.NAPPL__c == true)
            APPL = true;
            if(j.p.Trail_Custom_or_Promo__c == true){
            TCP = true;
            price = false;
            }
        i++;
        }
    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please add Quantity value '));   
    //return null;
    }

if(i>1)
{
	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Choose One Product Only '));   
	return null;
}

if(i==0)
{
	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Choose One Product Atleast '));   
	return null;
}

system.debug('toSelect'+toSelect);
system.debug('toSelect'+Quantity);

if(TCP == true){
return page.Configure_Product_TCP;
}
else{return page.Configure_Product_Attribute;}

}
 /*Attribute Config*/
 
    
    Public void Configure_Product_Attribute (){
        price = true;
        cshow = false;
        ppa = new Product_Attribute__c();
        law = new List<AttWrap>();
        
        ProductM__c pm = new ProductM__c();
        pm = [select id from ProductM__c where Name='Premium Resume Search' limit 1];
        pmmid = pm.id;
        if(toselect==pm.Id){
            
            debug = 'Am Inside';
            
            state1 = new List<Selectoption>();
            state2 = new List<Selectoption>();
            state3 = new List<Selectoption>();
            city1 = new List<Selectoption>();
            city2 = new List<Selectoption>();
            stateorcity = new List<Selectoption>();
            
            state1.add(new SelectOption('None','None'));
            state1.add(new SelectOption('Maharashtra (Including Mumbai & Pune),Goa','Maharashtra (Including Mumbai & Pune),Goa'));
            state1.add(new SelectOption('Karnataka (Including Bengaluru)','Karnataka (Including Bengaluru)'));
            state1.add(new SelectOption('Andhra Pradesh & Telangana(Including Hyderabad)','Andhra Pradesh & Telangana(Including Hyderabad)'));
            state1.add(new SelectOption('Tamil Nadu (Including Chennai)','Tamil Nadu (Including Chennai)'));
            state1.add(new SelectOption('North India ( UP, Rajasthan, Punjab, Haryana, Delhi, Himachal Pradesh, Jammu& Kashmir )','North India ( UP, Rajasthan, Punjab, Haryana, Delhi, Himachal Pradesh, Jammu& Kashmir )'));
                 

            state2.add(new SelectOption('None','None'));
            //state2.add(new SelectOption('Maharashtra(Excluding Mum/Pune)','Maharashtra(Excluding Mum/Pune)'));
            //state2.add(new SelectOption('Karnataka(Excluding Bangalore)','Karnataka(Excluding Bangalore)'));
            //state2.add(new SelectOption('Andhra Pradesh & Telangana(Excluding Hyderabad)','Andhra Pradesh & Telangana(Excluding Hyderabad)'));
            //state2.add(new SelectOption('Tamil Nadu (Excluding Chennai)','Tamil Nadu (Excluding Chennai)'));
            state2.add(new SelectOption('Punjab(Including Chandigarh/Mohali)','Punjab(Including Chandigarh/Mohali)'));
            state2.add(new SelectOption('Gujarat','Gujarat'));
            state2.add(new SelectOption('Kerala','Kerala'));
            state2.add(new SelectOption('Rajasthan,Haryana','Rajasthan,Haryana'));
            state2.add(new SelectOption('Uttar Pradesh,Uttranchal','Uttar Pradesh,Uttranchal'));
            state2.add(new SelectOption('Eastern India -West Bengal,Orrisa,Jharkand,Bihar,North Eastern Regions','Eastern India -West Bengal,Orrisa,Jharkand,Bihar,North Eastern Regions'));
            state2.add(new SelectOption('Madhya Pradesh,Chattisgarh','Madhya Pradesh,Chattisgarh'));
            
            state3.add(new SelectOption('None','None'));
            state3.add(new SelectOption('Andaman & Nicobar Islands','Andaman & Nicobar Islands'));
            state3.add(new SelectOption('Bihar','Bihar'));
            state3.add(new SelectOption('Chattisgarh','Chattisgarh'));
            state3.add(new SelectOption('Goa','Goa'));
            state3.add(new SelectOption('Haryana','Haryana'));
            state3.add(new SelectOption('Himachal Pradesh','Himachal Pradesh'));
            state3.add(new SelectOption('Jammu & Kashmir','Jammu & Kashmir'));
            state3.add(new SelectOption('Jharkand','Jharkand'));
            state3.add(new SelectOption('Madhya Pradesh','Madhya Pradesh'));
            state3.add(new SelectOption('Orissa','Orissa'));
            state3.add(new SelectOption('Uttaranchal','Uttaranchal'));
            state3.add(new SelectOption('North Eastern Regions','North Eastern Regions'));
            
            city1.add(new SelectOption('None','None'));
            city1.add(new SelectOption('Delhi-NCR','Delhi-NCR'));
            city1.add(new SelectOption('Mumbai','Mumbai'));
            city1.add(new SelectOption('Bengaluru','Bengaluru'));
            city1.add(new SelectOption('Hyderabad','Hyderabad'));
            city1.add(new SelectOption('Chennai','Chennai'));
            city1.add(new SelectOption('Pune','Pune')); 
            
            city2.add(new SelectOption('None','None'));
            city2.add(new SelectOption('Kolkata','Kolkata'));
            city2.add(new SelectOption('Ahmedabad','Ahmedabad'));
            city2.add(new SelectOption('Jaipur','Jaipur'));
            city2.add(new SelectOption('Chandigarh','Chandigarh'));
            city2.add(new SelectOption('Lucknow','Lucknow'));
            city2.add(new SelectOption('Coimbatore','Coimbatore'));
            city2.add(new SelectOption('Nagpur','Nagpur'));
            city2.add(new SelectOption('Bhopal','Bhopal'));
            city2.add(new SelectOption('Kanpur','Kanpur'));
            city2.add(new SelectOption('Madurai','Madurai'));
            city2.add(new SelectOption('Trichy','Trichy'));
            city2.add(new SelectOption('Ludhiana','Ludhiana'));
            city2.add(new SelectOption('Indore','Indore'));
            city2.add(new SelectOption('Vizag','Vizag'));
            city2.add(new SelectOption('Bhubaneshwar','Bhubaneshwar'));
            city2.add(new SelectOption('Surat','Surat'));
            city2.add(new SelectOption('Kochi','Kochi'));
            city2.add(new SelectOption('Tiruvananthapuram','Tiruvananthapuram'));
            city2.add(new SelectOption('Baroda','Baroda'));
            city2.add(new SelectOption('Patna','Patna'));
            
            
        }
        
        
        
        ppa = [select Attributes__c,product__r.Trail_Custom_or_Promo__c  from Product_Attribute__c where Product__c = :toselect  limit 1];
        //new change pramodh
        if(ppa.product__r.Trail_Custom_or_Promo__c)
        price = false;
        //pramodh
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
        pa = [select Set__c,get__c from Product_Attribute_Value__c where Product__c = :toselect  and Get__c = :qs and Product_PriceList__c=:pbid limit 1];
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
    
    Public pagereference configchange(){
        soc = false;
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
            pa = [select Set__c,Get__c  from Product_Attribute_Value__c where Product__c = :toselect  and Get__c = :qs and Product_PriceList__c=: pbid limit 1];
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
        
        if(pa.Set__c.contains('S1') || pa.Set__c.contains('S2') || pa.Set__c.contains('S3') || pa.Set__c.contains('C1') || pa.Set__c.contains('C2') ){
            if(pa.Set__c.contains('S1'))stateorcity = state1;
            else if(pa.Set__c.contains('S2'))stateorcity = state2;
            else if(pa.Set__c.contains('S3'))stateorcity = state3;
            else if(pa.Set__c.contains('C1'))stateorcity = city1;
            else if(pa.Set__c.contains('C2'))stateorcity = city2;
            soc = true;
        }
        
        if(pa.Set__c.contains('Final') && soc == true && stateorcity_val != 'None'){
            price = false;
        }
        if(pa.Set__c.contains('Final') && soc == false){
            price = false;
        }        
        return null;
    }
    
    
    Public pagereference chk(){
        soc = false;
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
    
    /*Public void generatecombo(){
        pbkey = 'Product'+toselect;
        Product_Price_Entry__c  pbe = new Product_Price_Entry__c();
        pbe = [SELECT Id, Name, Product__c, PriceList__c FROM Product_Price_Entry__c WHERE Product__c =: toselect and PriceList__c =: pbid limit 1];
        for(AttWrap aw : law){
            pbkey = pbkey+':'+aw.socv;
        }
          Product_Price_Metrix__c sobj = new Product_Price_Metrix__c(
          Product_Price_Entry__c = pbe.id,            // Product Price Entry
          Product_Config_Code__c = pbkey,
          Currency__c = Amount 
        );
        insert sobj;
    }*/
    
    Public pagereference Get_Price(){
        String qs;
        Product_Price_Entry__c pr = new Product_Price_Entry__c();
        Product_Price_Metrix__c prm = new Product_Price_Metrix__c();
        for(AttWrap ss : law){
                if(ss.socv != ''){
                    if(qs==null)
                    qs = ss.socv;
                    else
                    qs = qs+'-'+ss.socv;                    
                    system.debug('Price Query String'+qs);
                }    
            }
            system.debug('Price Query String'+qs);
            system.debug('ts'+toselect+'pl'+pbid);
            try{
            pr = [SELECT Id, Name, Product__c, PriceList__c FROM Product_Price_Entry__c Where Product__c =: toselect and PriceList__c =: pbid limit 1];
            system.debug('prid'+pr.id);
            prm = [SELECT Id, Name, Product_Price_Entry__c, Product_Config_Code__c, Currency__c, Max__c, Min__c,Product_Price_Entry__r.PriceList__r.Name FROM Product_Price_Metrix__c where Product_Price_Entry__c=:pr.id and Product_Config_Code__c=:qs and Min__c<=:quantity and Max__c>=:quantity limit 1];
            }
            catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,qs+' :E: '+e+' prid '+pr.id+' pbid '+pbid+' toselect '+toselect));
                return null;
            }
            currencytype = prm.Product_Price_Entry__r.PriceList__r.Name;
            amount= prm.Currency__c.setScale(2);            
            cshow = true;
              // congif=qs;
            return null;
         
    }
     Public pagereference Get_Price_TCP(){
         if((amount1 == null || amount1 == 0) && APPL == true){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Mandatory fields not updated : Rate as per Price List'));
                return null;
            }
             
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
            system.debug('ts'+toselect+'pl'+pbid);
            try{
            pr = [SELECT Id, Name, Product__c, PriceList__c FROM Product_Price_Entry__c Where Product__c =: toselect and PriceList__c =: pbid limit 1];
            system.debug('prid'+pr.id);
            prm = [SELECT Id, Name, Product_Price_Entry__c, Product_Config_Code__c, Currency__c, Max__c, Min__c,Product_Price_Entry__r.PriceList__r.Name FROM Product_Price_Metrix__c where Product_Price_Entry__c=:pr.id /*and Product_Config_Code__c=:qs and Min__c<=:quantity and Max__c>=:quantity*/ limit 1];
            }
            catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,qs+' :E: '+e+' prid '+pr.Name+' pbid '+pbid+' toselect '+toselect));
                return null;
            }
            currencytype = prm.Product_Price_Entry__r.PriceList__r.Name;
            amount= prm.Currency__c.setScale(2);
            cshow = true;
            congif=qs;              
            return null;       
    }
    
    
 /*Attribute Config*/  
 
 public pagereference Add_to_cart()
 {

 h.Product__c=toSelect;
h.Quantity__c=quantity;
h.Proposal_Locked__c=qid;
h.price__C=amount;
if(TCP == true)
h.price__C=amount1;
h.Start_Date__c=system.today();
h.APTS_Attribute_Display__c=congif;
if(congif.contains('Contract Duration='))
{
string contractduration=congif.substringBetween('Contract Duration=',';');
h.Contract_Duration1__c=contractduration;
    if(h.Contract_Duration1__c=='1 Month')
        {
            
           h.End_Date__c= h.Start_Date__c.addMonths(1);
           
        
        }else if(h.Contract_Duration1__c=='3 Months')
        {
            
           h.End_Date__c=h.Start_Date__c.addMonths(3);
        
        
        }else if(h.Contract_Duration1__c=='6 Months')
        {
           
           h.End_Date__c=h.Start_Date__c.addMonths(6);
        
        
        }else
        {
        
            
            h.End_Date__c=h.Start_Date__c.addMonths(12);
        
        }
}

if(toselect==pmmid)h.APTS_Attribute_Display__c=congif+':State/City='+stateorcity_val;


insert h;

return new pagereference('/apex/q_discount?id='+qid);
 
 
 }
 
 
    public pagereference canceling()
 { return new pagereference('/apex/Add_product1?pbid='+pbid+'&qid='+qid);
 
 }
 
 
    public pagereference to_quote()
 { return new pagereference('/'+qid);
 
 }
 
    
}