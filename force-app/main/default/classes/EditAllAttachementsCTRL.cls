public without sharing class EditAllAttachementsCTRL {
    //List<ContentVersion> att;
    @AuraEnabled
    public static List<ContentVersion> get_Attachements(String recordId) {
        List<ContentVersion> att;
        att = [SELECT Id, Title, Description, CreatedDate, LastModifiedDate, FileType, ContentDocumentId,
               ContentLocation, FirstPublishLocationId 
               FROM ContentVersion
               WHERE FirstPublishLocationId =: recordId
              ];
        system.debug('Attachent Item ='+att);
        return att;
        
    }
     @AuraEnabled
    public static List<Attachment> get_Attachements1(String recordId) {
        
      List<Attachment>  attch = [SELECT id,name FROM Attachment WHERE ParentID =:recordId];
        system.debug('Attachent Item 1 ='+attch);
        return attch;
        
    }
    @AuraEnabled
    public static List<Attachment> lineItemDel(String rid,string oid){
        system.debug('oid:'+oid);
              List<Attachment>  attch = [SELECT id,name FROM Attachment WHERE Id =:oid];
        system.debug('odelet:'+attch);
        delete attch;
        
                      List<Attachment>  attch1 = [SELECT id,name FROM Attachment WHERE parentid =:rid];
           
        return attch1;

    }
    @AuraEnabled
    public static string getstatus(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c from QuotesN__c where id=:rid];
        
        return qq.Approval_Status_Overall__c;
    }
     @AuraEnabled
    public static String onsave1(String recordId, List<Attachment> attch, List<String> ids) {
       /* List<Attachment> attch;
        attch = [SELECT id,name FROM Attachment WHERE parentid =:docIds];
        system.debug('attchment to delete:'+attch);*/
        system.debug('attch size:'+attch.size());
        system.debug('ids:'+ids);
        set<Id> uid=new set<Id>();
        List<string> str=new List<string>();
                              List<Attachment>  attchh1 = [SELECT id,name FROM Attachment WHERE parentid =:ids];
                  List<Attachment>  attchh = [SELECT id,name FROM Attachment WHERE parentid =:recordId];
                  Map<Id, Attachment> map_doc = new Map<Id, Attachment> ();
        
        for(Attachment att : attchh) {
            str.add(att.Id);
        }
        for(string s:str){
            if(!uid.contains(s)){
                uid.add(s);
            }
        }
        system.debug('uid:'+uid);
            
            for(Attachment cv : attchh1) {
                map_doc.put(cv.Id, cv);
            }
            
            List<String> del_list = new List<String> ();
            for(Attachment cv : attchh) {
                if(!map_doc.containsKey(cv.Id)) del_list.add(cv.Id);
            }
            system.debug('del_list:'+del_list);
            List<Attachment> del_cd = [SELECT Id FROM Attachment WHERE parentid =: uid];
            if(del_cd.size() > 0) delete del_cd;

       /* if(attch.size()==0){
          List<Attachment>  attchh = [SELECT id,name FROM Attachment WHERE parentid =:recordId];

            delete attchh;
        }
        if(attch.size()>0){
           delete attch;

        }*/

        
        //system.debug('attch to del:'+attch);
        
        return 'success';
    }
    @AuraEnabled
    public static String onsave(String recordId, List<String> docIds) {
        try{
            List<ContentVersion> old_doc = [SELECT Id, Title, Description, CreatedDate, LastModifiedDate, FileType, ContentDocumentId,
                                            ContentLocation, FirstPublishLocationId 
                                            FROM ContentVersion
                                            WHERE FirstPublishLocationId =: recordId
                                           ];
            
            List<ContentVersion> new_doc = [SELECT Id, Title, Description, CreatedDate, LastModifiedDate, FileType, ContentDocumentId,
                                            ContentLocation, FirstPublishLocationId 
                                            FROM ContentVersion
                                            WHERE Id =: docIds
                                           ];
            
            Map<Id, ContentVersion> map_doc = new Map<Id, ContentVersion> ();
            
            for(ContentVersion cv : new_doc) {
                map_doc.put(cv.Id, cv);
            }
            
            List<String> del_list = new List<String> ();
            for(ContentVersion cv : old_doc) {
                if(!map_doc.containsKey(cv.Id)) del_list.add(cv.ContentDocumentId);
            }
            
            List<ContentDocument> del_cd = [SELECT Id FROM ContentDocument WHERE Id =: del_list];
            if(del_cd.size() > 0) delete del_cd;
            
            return 'success';

        }
        catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
    }
    /* try {
List<ContentDocument> oldatt;
oldatt = [SELECT Id, CreatedDate, LastModifiedDate, Title,LatestPublishedVersionId, ParentId, Description,
FileType,ContentAssetId FROM ContentDocument
WHERE LatestPublishedVersionId =: recordId
];

Map<Id, ContentDocument> newatt = new Map<Id, ContentDocument> ();        
for(ContentDocument item : att) {
newatt.put(item.Id, item);
}

for(ContentDocument item : oldatt) {
if(newatt.containsKey(item.Id)) {
ContentDocument Docs = newatt.get(item.Id);
update Docs;
}
else {
delete item;
}
}   
}
catch(Exception e) {
throw new AuraHandledException('Something went wrong: '+e.getMessage());
}
}*/
}