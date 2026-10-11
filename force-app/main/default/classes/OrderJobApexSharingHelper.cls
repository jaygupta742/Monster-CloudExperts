/*Last Modified By : Abdul Aziz , Date : 13/09/2023 , Stop Order Sharing with Quote Owner and Manager*/
public class OrderJobApexSharingHelper {        
    public static Boolean isFirstRun = true;
    
    public static void shareOrderRevamp(List<Order__c> order) {
        User userInformation = [SELECT Id, Name, Department, email, Title, MobilePhone, Phone,manager.name,manager.Id
                                FROM User WHERE Id=:UserInfo.getUserId()];
        
        Set<id> setoforderid = new Set<id>();
        List<Order__c> orderlist=new  List<Order__c>();
        for(Order__c job : order){
            setoforderid.add(job.Id);  
        }
        
        orderlist = [SELECT Id, Name, Quotes__c, Quotes__r.OwnerId, Account__c, Account__r.OwnerId, OwnerId,
                     Shared_with_Person_1__c,Shared_with_Person_1__r.id,Shared_with_Person_2__c,Shared_with_Person_2__r.id,
                     Shared_with_Person_3__c,Shared_with_Person_3__r.id
                     FROM Order__c WHERE Id in: setoforderid];
        
        Set<Id> setUserId = new Set<Id> ();
        for(Order__c item : orderlist) {
            setUserId.add(item.OwnerId);
            setUserId.add(item.Quotes__r.OwnerId);
            setUserId.add(item.Account__r.OwnerId);
            if(item.Shared_with_Person_1__c!=null){setUserId.add(item.Shared_with_Person_1__r.id);}
            if(item.Shared_with_Person_2__c!=null){setUserId.add(item.Shared_with_Person_2__r.id);}
            if(item.Shared_with_Person_3__c!=null){setUserId.add(item.Shared_with_Person_3__r.id);}  
        }
        List<User> userlist=[select userName,id,manager.name,manager.Id,managerid from user where id in :setUserId];
        Map<id,user> mapofuser=new  Map<id,user>(userlist);
        
        List<Order__Share> jobShrs  = new List<Order__Share>();
        for(Order__c job : orderlist){
            /*Share with Order Owner Manager*/
            if(mapofuser.containskey(job.OwnerId) ){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.OwnerId).managerid;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }
            /*Share with Quote Owner*/
          /*  if(mapofuser.containskey(job.Quotes__r.OwnerId) ){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Quotes__r.OwnerId).id;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }*/
            /*Share with Account Owner*/
            if(mapofuser.containskey(job.Account__r.OwnerId)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Account__r.OwnerId).id;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }
            /*Share with Quote Owner Manager*/
          /*  if(mapofuser.containskey(job.Quotes__r.OwnerId)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Quotes__r.OwnerId).managerid;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }*/
            /*Share with Account Owner Manager*/
            if(mapofuser.containskey(job.Account__r.OwnerId)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Account__r.OwnerId).managerid;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }  
            /*Share with Person 1*/
            if(mapofuser.containskey(job.Shared_with_Person_1__c)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Shared_with_Person_1__c).id;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }  
            /*Share with Person 2*/
            if(mapofuser.containskey(job.Shared_with_Person_2__c)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Shared_with_Person_2__c).id;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }  
            /*Share with Person 3*/
            if(mapofuser.containskey(job.Shared_with_Person_3__c)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Shared_with_Person_3__c).id;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }  
            /*Share with Person 1 Manager*/
            if(mapofuser.containskey(job.Shared_with_Person_1__c)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Shared_with_Person_1__c).managerid;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }  
            /*Share with Person 2 Manager*/
            if(mapofuser.containskey(job.Shared_with_Person_2__c)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Shared_with_Person_2__c).managerid;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }  
            /*Share with Person 3 Manager*/
            if(mapofuser.containskey(job.Shared_with_Person_3__c)){
                Order__Share orderShare = new Order__Share();
                orderShare.ParentId = job.Id;
                orderShare.UserOrGroupId = mapofuser.get(job.Shared_with_Person_3__c).managerid;
                orderShare.AccessLevel = 'edit';
                jobShrs.add(orderShare);
            }  
        }
        if(jobShrs.size() > 0) {
            Database.SaveResult[] lsr = Database.insert(jobShrs, false);
        }
    } 
    
    public static void shareOrderWithSharedPerson(List<Order__c> lstOrderNew, List<Order__c> lstOrderOld) {
        Map<Id, Order__c> mapOldOrder = new Map<Id, Order__c> (lstOrderOld);
        
        Set<id> setoforderid = new  Set<id>();
        List<Order__c> orderlist = new  List<Order__c>();
        List<wrapSharedData> lstSharedOrder = new List<wrapSharedData> ();
        for(Order__c job : lstOrderNew) {
            Order__c oldOrder = mapOldOrder.get(job.Id);
            
            if(job.Shared_with_Person_1__c != oldOrder.Shared_with_Person_1__c) lstSharedOrder.add(new wrapSharedData(job.Id, job.Shared_with_Person_1__c));
            if(job.Shared_with_Person_2__c != oldOrder.Shared_with_Person_2__c) lstSharedOrder.add(new wrapSharedData(job.Id, job.Shared_with_Person_2__c));
            if(job.Shared_with_Person_3__c != oldOrder.Shared_with_Person_3__c) lstSharedOrder.add(new wrapSharedData(job.Id, job.Shared_with_Person_3__c));
        }
        
        List<Order__Share> jobShrs  = new List<Order__Share>();
        
        for(wrapSharedData job : lstSharedOrder){
            Order__Share orderShare = new Order__Share();
            orderShare.ParentId = job.ParentId;
            orderShare.UserOrGroupId = job.ownerId;
            orderShare.AccessLevel = 'edit';
            jobShrs.add(orderShare);
        }
        
        if(jobShrs.size() > 0) {
            Database.SaveResult[] lsr = Database.insert(jobShrs, false);
        }
    } 
    
    //This method will prevent duplicate orders for a perticular Quote | Before Insert
    public static void preventDuplicateOrders(List<Order__c> newOrders) {
        Set<Id> quoteIds = new Set<Id>();
        for (Order__c ord : newOrders) {
            quoteIds.add(ord.Quotes__c);
        }
        
        List<Order__c> existingOrders = [SELECT Quotes__c FROM Order__c WHERE Quotes__c IN :quoteIds];
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@  get duplicate list @@@@@@@@@@@@@@@@@@  '+existingOrders.size());
        Set<Id> existingQuoteIds = new Set<Id>();
        for(Order__c order : existingOrders) {
            existingQuoteIds.add(order.Quotes__c);
        }
        for(Order__c order : newOrders) {
            if(order.Quotes__c!=null){
                if(existingQuoteIds.contains(order.Quotes__c)) {
                    order.addError('You cannot create a new order for this quote because an order already exists!!!');
                }   
            }
            
        }
    }
    
    public class wrapSharedData {
        public Id ParentId, OwnerId;
        public wrapSharedData(Id param1, Id param2) {
            ParentId = param1;
            OwnerId = param2;
        }
    }
}