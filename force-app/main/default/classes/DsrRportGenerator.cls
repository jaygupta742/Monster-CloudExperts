global class DsrRportGenerator implements Schedulable{
  Public list<apttus_proposal_proposal__c> ap; 
    
    global void execute(SchedulableContext sc){
              
    sendDsrRepo();
      
        
    }
    
    
    public void sendDsrRepo(){
        
        ap=new list<apttus_proposal_proposal__c>();
    ap=[select id,CurrencyIsoCode,pricelist__r.CurrencyIsoCode,Quote_Finalize_Date_Time__c,Owner_Location__c,Account__r.AccountID__c,Account__r.name,
       Base_Total__c,Total_Discount_Amount__c,Gross_Total__c,Tax_Amount__c,APTS_Quote_Type__c,Owner.name,Channel__c,Primary_Contact__r.name,
     Primary_Contact__r.MobilePhone,Primary_Contact__r.Email,Account__r.GST_ID__c,Account__r.VATNumber__c,Account__r.TAN__c,Start_Date__c,
     End_Date__c,Account__r.Segment__c,//yamini
        Account__r.BillingAddress,Account__r.BillingCity,Account__r.BillingCountry,
     Account__r.BillingState,Account__r.BillingStreet,Account__r.BillingPostalCode,Account__r.ShippingCity,Account__r.ShippingCountry,
       Account__r.ShippingState,Account__r.ShippingStreet,Account__r.ShippingPostalCode,/*Posting_Address__r.Address1__c,Posting_Address__r.City__c,Posting_Address__r.state__c,
    Posting_Address__r.Country__c,Posting_Address__r.PinCode__c,Billing_Address__r.Address1__c,Billing_Address__r.City__c,Billing_Address__r.state__c,
     Billing_Address__r.Country__c,Billing_Address__r.PinCode__c,*///@yamini 
                    (select id,Due_Date__c,Payment_Amount__c,APAC_Payment_Type__c from APAC_Payments__r),
                    (select id,Product_Name__c,Product__r.name,Product_Details__c,Product_Name_With_Attribute__c,Gross_Total__c,Base_Total__c from Quote_Line_Item__r),
                    (select id,Name,OrderDate__c,OwnerId,CurrencyIsoCode,QuoteProposal__c from Orders__r /*where CreatedDate=today*/)
                     from apttus_proposal_proposal__c where Order_Created_Date__c=today];
          System.debug('AAPPPP'+ap.size());
        
        set<id> ids =new Set<id>();
        for(apttus_proposal_proposal__c cc:ap){
            
            system.debug('Inside Owner'+cc.Orders__r.size());
             for(OrderC__c bb:cc.Orders__r){
            ids.add(bb.OwnerId);
             }
        }
         List<String> esend= new List<String>();
          List<String> esendcc= new List<String>();
        List<User> us= new List<User>();
      us=  [select id,name,manager.name,Email from User where id=:ids];
    system.debug('Inside Owner'+us.size());
    String fileheader='Order ID ,Order Date,Quote Finalized Date,Account ID,Account Name,Base Total,Total Discount Amount,Gross Total Amount,Tax Amount,Currency Name (Prefix on Base Total),Quote Type,Quote Owner,Quote Owner Location,Primary Sales Manager,Sales Channel,Primary Contact Name,Primary Contact Phone,Primary Contact Email,GST ID,VAT No,TAN No,Quote Start Date,Quote End Date,Segment,';
     
    String pli1='Quote line item Product Name -1,Quote line item Product Base Total-1,Quote line item Product Gross Total-1,';
    String pli2='Quote line item Product Name-2,Quote line item Product Base Total-2,Quote line item Product Gross Total-2,';    
    String pli3='Quote line item Product Name-3,Quote line item Product Base Total-3,Quote line item Product Gross Total-3,';
    String pli4='Quote line item Product Name-4,Quote line item Product Base Total-4,Quote line item Product Gross Total-4,';  
    String pli5='Quote line item Product Name-5,Quote line item Product Base Total-5,Quote line item Product Gross Total-5,';   
    String pli6='Quote line item Product Name-6,Quote line item Product Base Total-6,Quote line item Product Gross Total-6,';
    String pli7='Quote line item Product Name-7,Quote line item Product Base Total-7,Quote line item Product Gross Total-7,';
    String pli8='Quote line item Product Name-8,Quote line item Product Base Total-8,Quote line item Product Gross Total-8,';
    String pli9='Quote line item Product Name-9,Quote line item Product Base Total-9,Quote line item Product Gross Total-9,';    
    String pli10='Quote line item Product Name-10,Quote line item Product Base Total-10,Quote line item Product Gross Total-10,';
         
    String BuyerAdd='Buyer Street,Buyer City,Buyer State,Buyer Country,Buyer Pin Code4,';  
    String DelAdd='Delivery Street,Delivery City,Delivery State,Delivery Country,Delivery Pin Code4,';  
        
            String Apay1='PAC Payment Due Date 1,APAC Payment Amount 1,';
            String Apay2='APAC Payment Due Date 2,APAC Payment Amount 2,';
            String Apay3='APAC Payment Due Date 3,APAC Payment Amount 3 ,';
            String Apay4='APAC Payment Due Date 4,APAC Payment Amount 4,';
            String Apay5='APAC Payment Due Date 5,APAC Payment Amount 5,';
            String Apay6='APAC Payment Due Date 6,APAC Payment Amount 6,';
            String Apay7='APAC Payment Due Date 7,PAC Payment Amount 7,';
            String Apay8='APAC Payment Due Date 8,APAC Payment Amount 8,';
            String Apay9='APAC Payment Due Date 9,APAC Payment Amount 9,';
            String Apay10='APAC Payment Due Date 10,APAC Payment Amount 10,';
            String Apay11='APAC Payment Due Date 11,APAC Payment Amount 11,';
            String Apay12='APAC Payment Due Date 12,APAC Payment Amount 12,';
            String Apay13='APAC Payment Due Date 13,APAC Payment Amount 13,';
            String Apay14='APAC Payment Due Date 14,APAC Payment Amount 14,';
            String Apay15='APAC Payment Due Date 15,APAC Payment Amount 15,';
            String Apay16='APAC Payment Due Date 16,APAC Payment Amount 16,';
            String Apay17='APAC Payment Due Date 17,APAC Payment Amount 17,';
            String Apay18='APAC Payment Due Date 18,APAC Payment Amount 18,';
      // String BAdd='Billing Street,Billing City,Billing State,Billing Country,Billing Pincode,';        
       // String PAdd='Posting Street,Posting City,Posting State,Posting Country,Posting Pincode,';
          
        List<Messaging.SingleEmailMessage> m= new  list<Messaging.SingleEmailMessage>();

        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
             
        LIst<String> norecd= new List<String>();
        for(User u:us){
        Messaging.SingleEmailMessage m1= new  Messaging.SingleEmailMessage();
        Messaging.Emailfileattachment mat = new Messaging.Emailfileattachment();

           esendcc.add('crm@cloudexpertsindia.com');
             esend.add(u.Email);
            String hplusda;
       String fh=fileheader+pli1+pli2+pli3+pli4+pli5+pli6+pli7+pli8+pli9+pli10+BuyerAdd+DelAdd+Apay1+Apay2+Apay3
             +Apay4+Apay5+Apay6+Apay7+Apay8+Apay9+Apay10+Apay11+Apay12+Apay13+Apay14+Apay15+Apay16+Apay17+Apay18+'\n';  
            m1.setSubject('Daily Order Report For Finance Team');
          
       for(apttus_proposal_proposal__c jj:ap) 
       {
         String badd=',,,,,'; 
           string pAdd=',,,,,';
     String Sdata=jj.Quote_Finalize_Date_Time__c+','+jj.Account__r.AccountID__c+','+jj.Account__r.name
       +','+ jj.Base_Total__c+','+jj.Total_Discount_Amount__c+','+jj.Gross_Total__c+','+jj.Tax_Amount__c+','+jj.pricelist__r.CurrencyIsoCode+','+jj.APTS_Quote_Type__c
      +','+jj.Owner.name+','+jj.Owner_Location__c+','+u.manager.name +','+jj.Channel__c+','+jj.Primary_Contact__r.name+','+jj.Primary_Contact__r.MobilePhone+','+jj.Primary_Contact__r.Email+','+
       jj.Account__r.GST_ID__c+','+jj.Account__r.VATNumber__c+','+jj.Account__r.TAN__c+','+jj.Start_Date__c+','+jj.End_Date__c
       +','+jj.Account__r.Segment__c+','; 
          
           String ql1=',,,';
           String ql2=',,,';
           String ql3=',,,';
           String ql4=',,,';
           String ql5=',,,';
           String ql6=',,,';
           String ql7=',,,'; 
           String ql8=',,,';
           String ql9=',,,'; 
           String ql10=',,,';
             Integer count=1; 
           double btotal1=0;
            double btotal2=0;
            double btotal3=0;
            double btotal4=0;
            double btotal5=0;
            double btotal6=0;
            double btotal7=0;
            double btotal8=0;
            double btotal9=0;
            double btotal10=0;
            double gtotal1=0,gtotal2=0,gtotal3=0,gtotal4=0,gtotal5=0,gtotal6=0,gtotal7=0,gtotal8=0,gtotal9=0,gtotal10=0;
         
           
          integer count1=1,count2=1,count3=1,count4=1,count5=1,count6=1,count7=1,count8=1,count9=1,count10=1;
            
           
           for(Proposal_Line_Item__c dd:jj.Quote_Line_Item__r){
              
                String st=dd.Product_Name_With_Attribute__c;
              
               if(st.contains('Master') && st.contains('India')){
                   btotal1=btotal1+dd.Base_Total__c;
                   gtotal1=gtotal1+dd.Gross_Total__c;
                    ql1=dd.Product__r.name+'-'+count1+','+btotal1+','+gtotal1+',';
                   count1++;
               }
               
              else  if(st.contains('Additional Login') && st.contains('India')){
                   btotal2=btotal2+dd.Base_Total__c;
                   gtotal2=gtotal2+dd.Gross_Total__c;
                    ql2=dd.Product__r.name+'-'+count2+','+btotal2+','+gtotal2+',';
                   count2++;
               }
               
                
               else if(st.contains('Job Postings') && st.contains('India')){
                   btotal3=btotal3+dd.Base_Total__c;
                   gtotal3=gtotal3+dd.Gross_Total__c;
                    ql3=dd.Product__r.name+'-'+count3+','+btotal3+','+gtotal3+',';
                   count3++;
               }
               else if(st.contains('Brandings') && st.contains('India')){
                   
                    btotal4=btotal4+dd.Base_Total__c;
                   gtotal4=gtotal4+dd.Gross_Total__c;
                    ql4=dd.Product__r.name+'-'+count4+','+btotal4+','+gtotal4+',';
                   count4++;
               }
               
              else  if(st.contains('SMS & Target Mailers') && st.contains('India')){
                   
                   btotal5=btotal5+dd.Base_Total__c;
                   gtotal5=gtotal5+dd.Gross_Total__c;
                    ql5=dd.Product__r.name+'-'+count5+','+btotal5+','+gtotal5+',';
                   count5++;
               }
                
               else if(st.contains('Type=master') && st.contains('Country=APAC Region except India')){
                   
                    btotal6=btotal6+dd.Base_Total__c;
                   gtotal6=gtotal6+dd.Gross_Total__c;
                    ql6=dd.Product__r.name+'-'+count6+','+btotal6+','+gtotal6+',';
                   count6++;
               }
               

               else  if(st.contains('Job Postings') && st.contains('Country=APAC Region except India')){
                   
                  btotal7=btotal7+dd.Base_Total__c;
                   gtotal7=gtotal7+dd.Gross_Total__c;
                    ql7=dd.Product__r.name+'-'+count7+','+btotal7+','+gtotal7+',';
                   count7++;
               }
               
              else   if(st.contains('Type=master') && st.contains('Country = Outside APAC Region')){
                   
                  btotal8=btotal8+dd.Base_Total__c;
                   gtotal8=gtotal8+dd.Gross_Total__c;
                    ql8=dd.Product__r.name+'-'+count8+','+btotal8+','+gtotal8+',';
                   count8++;
               }
              
            else  if(st.contains('Job Postings') && st.contains('Country=Outside APAC Region')){
                   
                   btotal9=btotal9+dd.Base_Total__c;
                   gtotal9=gtotal9+dd.Gross_Total__c;
                    ql9=dd.Product__r.name+'-'+count9+','+btotal9+','+gtotal9+',';
                   count9++;
             }
              
              else  /*if(st.contains('Others') && st.contains('Others'))*/{ 
                   
                   btotal10=btotal10+dd.Base_Total__c;
                   gtotal10=gtotal10+dd.Gross_Total__c;
                    ql10=dd.Product__r.name+'-'+count10+','+btotal10+','+gtotal10+',';
                   count10++;
               }
               
           }
           
           
           String finalQli=ql1+ql2+ql3+ql4+ql5+ql6+ql7+ql8+ql9+ql10;
           
           
           String ap1=',';
           String ap2=',';
           String ap3=',';
           String ap4=',';
           String ap5=',';
           String ap7=','; 
           String ap6=',';
           String ap8=',';
           String ap9=',';
           String ap10=',';
           String ap11=',';
           String ap12=','; 
           String ap13=',';
           String ap14=',';
           String ap15=',';
           String ap16=',';
           String ap17=',';
           String ap18=',';
            
           for(APTS_APAC_Payment__c ee:jj.APAC_Payments__r){
               
               if(ee.APAC_Payment_Type__c=='Single Shot' ||ee.APAC_Payment_Type__c=='Installment - 1' ){
                    Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                   
                  ap1=x+','+ee.Payment_Amount__c+','; 
               }
             
               if(ee.APAC_Payment_Type__c=='Installment - 2'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                  ap2=x+','+ee.Payment_Amount__c+','; 
               }
                
               if(ee.APAC_Payment_Type__c=='Installment - 3'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap3=x+','+ee.Payment_Amount__c+','; 
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 4'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap4=x+','+ee.Payment_Amount__c+','; 
               }
              /* if(ee.Due_Date__c.month()+4==system.today().month()+4){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                   String ap4=x+','+ee.Payment_Amount__c; 
               }*/
               
               if(ee.APAC_Payment_Type__c=='Installment - 5'){
                   
                  Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap5=x+','+ee.Payment_Amount__c+','; 
               }
              
               if(ee.APAC_Payment_Type__c=='Installment - 6'){
                   
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap6=x+','+ee.Payment_Amount__c+',';                }
               
               
               if(ee.APAC_Payment_Type__c=='Installment - 7'){
                   
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                  ap7=x+','+ee.Payment_Amount__c+','; 
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 8'){
                   
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap8=x+','+ee.Payment_Amount__c+',';  
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 9'){
                   
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                 ap9=x+','+ee.Payment_Amount__c+',';  
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 10'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                   ap10=x+','+ee.Payment_Amount__c+','; 
                   
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 11'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap11=x+','+ee.Payment_Amount__c+','; 
                   
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 12'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap12=x+','+ee.Payment_Amount__c+','; 
                   
               }
              
               if(ee.APAC_Payment_Type__c=='Installment - 13'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                    ap13=x+','+ee.Payment_Amount__c+',';  
                   
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 14'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                  ap14=x+','+ee.Payment_Amount__c+',';  
                   
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 15'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                ap15=x+','+ee.Payment_Amount__c+','; 
                   
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 16'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                   ap16=x+','+ee.Payment_Amount__c+','; 
                   
               }
               if(ee.APAC_Payment_Type__c=='Installment - 17'){
                   Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                   ap17=x+','+ee.Payment_Amount__c+','; 
                   
               }
               
               if(ee.APAC_Payment_Type__c=='Installment - 18'){
                  Date dateTemp=    ee.Due_Date__c;
                   String x=dateTemp.format();
                   ap18=x+','+ee.Payment_Amount__c+','; 
                   
               }
               
           }
           /*string street1=jj.Billing_Address__r.Address1__c;
            string street2=jj.Posting_Address__r.Address1__c;
           string street3= street1.replaceAll('[^a-zA-Z0-9]', ' ');
               string street4=street2.replaceAll('[^a-zA-Z0-9]', ' ');
           
           
           String finalapc=ap1+ap2+ap3+ap4+ap5+ap6+ap7+ap8+ap9+ap10+ap11+ap12+ap13+ap14+ap15+ap16+ap17+ap18;
           badd=street3+','+jj.Billing_Address__r.City__c+','+jj.Billing_Address__r.state__c+','+
                                                    jj.Billing_Address__r.Country__c+','+jj.Billing_Address__r.PinCode__c+','; 
         padd=  street4+','+jj.Posting_Address__r.City__c+','+jj.Posting_Address__r.state__c+','+
                                                    jj.Posting_Address__r.Country__c+','+jj.Posting_Address__r.PinCode__c+',';  */
           
           string street1=jj.Account__r.BillingStreet  ;
            string street2=jj.Account__r.ShippingStreet ;
           
           string street3= street1.replaceAll('[^a-zA-Z0-9]', ' ');
               string street4=street2.replaceAll('[^a-zA-Z0-9]', ' ');
           
           
           String finalapc=ap1+ap2+ap3+ap4+ap5+ap6+ap7+ap8+ap9+ap10+ap11+ap12+ap13+ap14+ap15+ap16+ap17+ap18;
           badd=street3+','+jj.Account__r.BillingCity +','+jj.Account__r.BillingState+','+
                                                    jj.Account__r.BillingCountry +','+jj.Account__r.BillingPostalCode+','; 
         padd=  street4+','+jj.Account__r.ShippingCity +','+jj.Account__r.ShippingState +','+
                                                    jj.Account__r.ShippingCountry+','+jj.Account__r.ShippingPostalCode+',';  
           
           
           
           
           
           String orderc;
           String finaldata;
           
           for(OrderC__c cc:jj.Orders__r){
                                   system.debug(u.id+'usernamesssssss'+jj.OwnerId);
                                     system.debug(cc.QuoteProposal__c+'quote'+jj.id);
                if(u.id==cc.OwnerId &&cc.QuoteProposal__c==jj.id){
                    system.debug(jj.OwnerId+'usernamesssssss'+jj.OwnerId);
              orderc =cc.name+','+cc.OrderDate__c+',';
          finaldata=orderc+Sdata+finalQli+badd+padd+finalapc+'\n';
              fh=fh+finaldata;      
                    
                } 
           }
          

        }
            
           blob ofile = Blob.valueOf(fh); 
            string myf= 'DailyOrderReport.csv';
             mat.setFileName(myf);
             mat.setBody(ofile);
           
            m1.setFileAttachments(new Messaging.EmailFileAttachment[]{mat});
           m1.setCcAddresses(esendcc);
           m1.setToAddresses(esend);
           m1.setPlainTextBody('Please Find your Order Detail Of Today');
            m.add(m1);
       }
       // Messaging.sendEmail(new Messaging.SingleEmailMessage[] {m});
         
        Messaging.sendEmail(m);   
    }
   

}