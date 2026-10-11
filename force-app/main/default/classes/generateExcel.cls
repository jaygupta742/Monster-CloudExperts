public class generateExcel 
{
    Public List<Product_Attribute_Value__c> pa = new List<Product_Attribute_Value__c>();
    Public List<Product_Price_Metrix__c> ppm = new List<Product_Price_Metrix__c>();
    Map<String,String> mapp = new Map<String,String>();
    integer count=0;
	public void genExc(id quoteId) 
    {
        pa=[select id,Name,Product__c,Product__r.name,Set__c,Product__r.id from Product_Attribute_Value__c where Product__r.Seeker_Products__c = false and  Product__r.Trail_Custom_or_Promo__c=false];
        
        system.debug('------------>pa size'+pa.size());
        for(Product_Attribute_Value__c pp : pa)
        {
            String ss;
            String values = '';
            String str=pp.Set__c;
            List<String> str1 = new List<String>();   
            
            if(str!=null && str.contains('Final'))
            {
              system.debug('values----->'+str);
              count++;
              str1.addAll(str.split(';'));
             
            }                       
              for(String st : str1)
              {
                    system.debug('st----->'+st);  
             	values=st.substringAfter('=');
                   system.debug('values----->'+values);
                if(values!= '' || values != NULL)
                  {
                    if(ss==null)
                    ss = values;                  	
                    else
                    ss = ss+'-'+values;                      
                	system.debug('ss------------>'+ss);                         
                  }
                   mapp.put(ss,pp.Set__c);
              }
            system.debug('mapp--->'+mapp);
            system.debug('content of map-ss'+ss);
            system.debug('content of map-pp.Set__c'+pp.Set__c);
        }   
        system.debug('count- -------->'+count);
        
        ppm=[select id,Name,Max__c,Min__c,Currency__c,Product_Config_Code__c,Product_Price_Entry__r.id,Product_Price_Entry__r.PriceList__c,Product_Price_Entry__r.Name,Product_Price_Entry__r.Product__c,Product_Price_Entry__r.Product__r.Name,Product_Price_Entry__r.Product__r.Id from Product_Price_Metrix__c where Product_Price_Entry__r.Product__r.Seeker_Products__c = false and  Product_Price_Entry__r.Product__r.Trail_Custom_or_Promo__c=false];
        
        string header = 'Product Id, ProductPriceMatrix Id, Product Name, Product Price List, Product Attribute Display, Product Config Code, Max, Min, Amount \n';
		string finalstr = header ;
        
            for(Product_Price_Metrix__c prodPricMatrx: ppm)
            {
                string recordString = prodPricMatrx.Product_Price_Entry__r.Product__r.id+','+prodPricMatrx.id+','+prodPricMatrx.Product_Price_Entry__r.Product__r.Name+','+prodPricMatrx.Product_Price_Entry__r.PriceList__c+','+mapp.get(prodPricMatrx.Product_Config_Code__c)+','+prodPricMatrx.Product_Config_Code__c+','+prodPricMatrx.Max__c+','+prodPricMatrx.Min__c+','+prodPricMatrx.Currency__c +'\n';              
       			system.debug('Finalllllllllstr------->'+recordString);
                finalstr = finalstr +recordString;
                system.debug('recordString-----> '+recordString);
                system.debug('finalstr-----> '+finalstr);
    		}
		Attachment att = new Attachment();
        att.ParentId=quoteId;
        att.Name = 'PCA.csv';
        att.Body = blob.valueof(finalstr);
        insert att; 
        
    }
}