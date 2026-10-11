public class BlockUserDownload implements Sfc.ContentDownloadHandlerFactory {
public Sfc.ContentDownloadHandler getContentDownloadHandler(List<ID> ids, Sfc.ContentDownloadContext c) {

Sfc.ContentDownloadHandler cdh = new Sfc.ContentDownloadHandler(); 
cdh.isDownloadAllowed = true;
List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
String myProflieName = profiles[0].Name;

/*if (myProflieName != 'System Admin') {
cdh.isDownloadAllowed = false;  // No download for: Standard User
cdh.downloadErrorMessage = 'User Profile: '+ myProflieName +' is not allowed to download.';
cdh.redirectUrl = '/apex/DownloadError' ; 
}*/
return cdh;
}
}