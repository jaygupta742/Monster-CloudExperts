@isTest
private class BlockUserDownload_test {
  static testMethod void testCreate() {
   
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName='jo@gh.com');
    system.runas(u)
    {
   
    ContentVersion contentVersion_1 = new ContentVersion(
      Title = 'Penguins',
      PathOnClient = 'Penguins.jpg',
      VersionData = Blob.valueOf('Test Content')
     );
    insert contentVersion_1;
    
      list<id> aa=new list<id>();
    aa.add(contentVersion_1.id);
    
  
    Sfc.ContentDownloadContext g=Sfc.ContentDownloadContext.MOBILE;
    BlockUserDownload jio=new BlockUserDownload();
    jio.getContentDownloadHandler(aa,g );
    }
    }
    
  
    
  }