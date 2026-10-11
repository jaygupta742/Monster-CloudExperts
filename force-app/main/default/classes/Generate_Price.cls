public class Generate_Price {

    public static void gencode()
    {list<Gencode__c> pm=new list<Gencode__c>();
          for(Gencode__c j: [SELECT Id, Name, Attribute_1__c, Attribute_2__c, Attribute_3__c, Attribute_4__c, Attribute_5__c, Attribute_6__c, Attribute_7__c, Attribute_8__c, Min__c, Max__c, Product__c, Unit_Price__c, Attribute_9__c FROM Gencode__c]) 
            {
                string s=j.Attribute_1__c+'-'+j.Attribute_2__c+'-'+j.Attribute_3__c+'-'+j.Attribute_4__c+'-'+j.Attribute_5__c+'-'+j.Attribute_6__c+'-'+j.Attribute_7__c/*+'-'+j.Attribute_8__c*/;
                system.debug('st'+s);
                Gencode__c g=j;
               g.Matrix_value__c=s;
                
                
                
               /* Product_Price_Metrix__c kl=new Product_Price_Metrix__c();
                kl.Product_Config_Code__c=s;
                kl.Product_Price_Entry__c='a047F0000062RIU';
                kl.Max__c=j.Max__c;
                kl.Min__c=j.Min__c;
                kl.Currency__c=j.Unit_Price__c;*/
                pm.add(g);
                
            }
            
           update pm;
    }
    
    public static void gencode1(ID ids)
    {
     list<Gencode__c> pm=new list<Gencode__c>();
     List<Product_Price_Metrix__c> lppm = new List<Product_Price_Metrix__c>();
     List<Product_Price_Entry__c> ppe = new List<Product_Price_Entry__c>([SELECT Id, Name, PriceList__c, Product__c FROM Product_Price_Entry__c where Product__c=: ids]);
          for(Gencode__c j: [SELECT Id, Name, Min__c, Max__c, Product__c,Matrix_value__c, Unit_Price__c, Product_PriceList__c FROM Gencode__c where Product__c=: ids]) 
            {
                for(Product_Price_Entry__c p : ppe){
                    if(j.Product_PriceList__c == p.PriceList__c && p.Product__c == j.Product__c){
                        Product_Price_Metrix__c ppm = new Product_Price_Metrix__c();
                        ppm.Max__c = j.Max__c;
                        ppm.Min__c = j.Min__c;
                        ppm.Product_Config_Code__c = j.Matrix_value__c;
                        ppm.Currency__c = j.Unit_Price__c;
                    	ppm.Product_Price_Entry__c = p.Id;
                        lppm.add(ppm);
                    }
                }
            }
        insert lppm;
    }


}