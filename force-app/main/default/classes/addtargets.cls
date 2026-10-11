public class addtargets {

    
    Public integer rowtoremove{get;set;}
    public List<Target__c> lt{get;set;}
    public addtargets(ApexPages.StandardController controller){
         lt = new List<Target__c>();
        Target__c t = new Target__c();
        lt.add(t);
    }
    Public pagereference addnew(){
        Target__c t = new Target__c();
        lt.add(t);
        return null;
    }
    Public pagereference copy(){
        List<Target__c> ltc = new List<Target__c>();
        for(Target__c t : lt){
                system.debug('1st'+t);
            if(t.select__c == true){
                system.debug('2nd'+t);
                Target__c tt = t;
                ltc.add(tt);
                //t.select__c = false;
            }
        }
        for(Target__c t : ltc){
            lt.add(t);
            system.debug('Hi'+t);
        }
        return null;
    }
    Public pagereference remove(){
        /*List<integer> rm = new List<integer>();
        for(Target__c t : lt){
            if(t.select__c == true){
                rm.add(lt.indexof(t));
            }
        }
        for(Integer t : rm){
            lt.remove(t);
        }*/
        lt.remove(rowtoremove-1);
        return null;
    }
    public pagereference save(){
        try{
        insert lt;
        }
        catch(Exception e){
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Error:'+e));
            return null;
        }
        return new Pagereference('/a0B?fcf=00B7F00000Dyku5');
    }
}