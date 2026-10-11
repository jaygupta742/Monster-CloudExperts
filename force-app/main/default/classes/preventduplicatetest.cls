@istest
Public Class preventduplicatetest{

public testmethod static void duptest(){
  Boolean result = false;
  
  
  Account acc =new Account();
  acc.name = 'Test';
  acc.Phone = '+7894561235';
  acc.Website ='www.test.com';
  insert acc;
  
  Contact con = new contact();
  con.LastName ='TestCon';
  con.AccountId = acc.id;
  con.Phone = '1234567895';
  con.MobilePhone ='1234567896';
  con.Email ='test@gmail.com';
  insert con;
  
  try{
  Account acc1 =new Account();
  acc1.name = 'Test';
  acc1.Phone = '+7894561235';
  acc1.Website ='www.test.com';
  //acc1.Allow_Duplicates__c =true;
  insert acc1;
  
  
  
  }
  
  catch(DmlException ex){ 
  result = true;
  }
  
  //System.assert(result);
  
  try{
  Contact con1 = new contact();
  con1.LastName ='TestCon';
  con1.AccountId = acc.id;
  con1.Phone = '1234567895';
  con1.MobilePhone ='1234567896';
  con1.Email ='test@gmail.com';
  insert con1;
  }

  catch(DmlException ex){ 
  result = true;
  }
  
  //System.assert(result);
  
  try{
  Contact con1 = new contact();
  con1.LastName ='TestCon';
  con1.AccountId = acc.id;
  con1.Phone = '1234567896';
  con1.MobilePhone ='1234567895';
  con1.Email ='test@gmail.com';
  insert con1;
  }

  catch(DmlException ex){ 
  result = true;
  }
  
  //System.assert(result);
  
  
  

}


}