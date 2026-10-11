public class TargetUpdate {
    @future
    Public static void updateusertarget(){
        
        LastRunTime__c lrt = LastRunTime__c.getValues('LastRun');
        
        Map<id,id> uidtid = new Map<id,id>();
        List<Target__c> lt = new List<Target__c>();
        lt = [SELECT Id, OwnerId, Name, CurrencyIsoCode, User__c, Start_Date__c, End_Date__c, Free_Trail__c, Demonstration__c, Unique_Account__c, Target_Type__c, Opportunity_Created_Target__c, Opportunity_Created_Achieved__c, Opportunity_Created_Balance__c, Opportunity_Won_Target__c, Opportunity_Won_Achieved__c, Opportunity_Won_Balance__c FROM Target__c WHERE Start_Date__c <= :system.today() and End_Date__c >= :system.today() ];
        for(Target__c temp : lt){
            uidtid.put(temp.User__c , temp.id);
        }
        List<Account> la = new List<Account>([select Target__c,ownerid from Account where ownerid = :uidtid.keySet() and createddate >= :lrt.LRT__c]);    
        for(Account a : la){
            a.Target__c = uidtid.get(a.ownerid);
        }
        //update la;
         Database.SaveResult[] laupdate = Database.update(la, false);
        List<Proposal_Line_Item__c> pli = new List<Proposal_Line_Item__c>([select Target__c,Proposal_Locked__r.ownerid,Free_Trail__c from Proposal_Line_Item__c where Proposal_Locked__r.ownerid = :uidtid.keySet() and createddate >= :lrt.LRT__c and Free_Trail__c =true]);
        for(Proposal_Line_Item__c li : pli){
            li.Target__c = uidtid.get(li.Proposal_Locked__r.ownerid);
        }
        //update pli;
        Database.SaveResult[] pliupdate = Database.update(pli, false);
        List<Event> le = new List<Event>([select Target__c,ownerid from Event where ownerid = :uidtid.keySet() and createddate >= :lrt.LRT__c and Subject = 'Demonstration']);
        for(Event e : le){
            e.Target__c = uidtid.get(e.ownerid);
        }
       // update le;
        Database.SaveResult[] leupdate = Database.update(le, false);
        List<Target_JN_Task__c> tasktarget = new List<Target_JN_Task__c>([select Target__c,ownerid from Target_JN_Task__c where ownerid = :uidtid.keySet() and createddate >= :lrt.LRT__c]);
        for(Target_JN_Task__c tj : tasktarget){
            tj.Target__c = uidtid.get(tj.ownerid);
        }
        //Update tasktarget;
        Database.SaveResult[] tasktargetupdate = Database.update(tasktarget, false);
        List<Opportunity__c> creatednwonopp = new List<Opportunity__c>([select Actual_Revenue__c,Target_Create__c,Target_Won__c,ownerid,Closed_Won_for_Target__c,createddate from Opportunity__c where ownerid = :uidtid.keySet() and (createddate >= :lrt.LRT__c or Closed_Won_for_Target__c >= :lrt.LRT__c)]);
        for(Opportunity__c co : creatednwonopp){
            
            if(co.createddate>= lrt.LRT__c){
              co.Target_Create__c = uidtid.get(co.ownerid);
            }
            if(co.Closed_Won_for_Target__c>= lrt.LRT__c){
              co.Target_Won__c = uidtid.get(co.ownerid);
            }
        }
        //update creatednwonopp;
          Database.SaveResult[] creatednwonopptupdate = Database.update(creatednwonopp, false);

        List<Task> lta = new List<Task>([select Target__c,ownerid from Task where ownerid = :uidtid.keySet() and createddate >= :lrt.LRT__c and (Subject = 'Fresh Meeting' OR Subject = 'Follow Up Meeting' OR Subject = 'Call')]);
        for(Task t : lta){
            t.Target__c = uidtid.get(t.ownerid);
        }
        //update lta;
        Database.SaveResult[] ltaupdate = Database.update(lta, false);
        
        List<Target__c> at = new List<Target__c>();
        at = [select id,Opportunity_Created_Achieved__c,Opportunity_Won_Achieved__c,Unique_Account_Completed__c,Free_Trail_Completed__c,Demonstration_Completed__c,(select id,Regular__c,Monthly__c from Target_JN_Tasks__r),(select id from Accounts__r),(select id from Proposal_Line_Items__r),(select id from Activities__r),(select Amount__c,Actual_Revenue__c from Opportunities__r),(select Expected_Revenue__c,Actual_Revenue__c from Opportunities1__r) from Target__c where id =: uidtid.values() ];
        Map<id,decimal> regulartask = new Map<id,decimal>();
        Map<id,decimal> monthlytask = new Map<id,decimal>();
        for(Target__c a : at){
            for(Target_JN_Task__c tj : a.Target_JN_Tasks__r){
                monthlytask.put(a.id,0);
                regulartask.put(a.id,0);
            }
        }
        for(Target__c a : at){
            for(Target_JN_Task__c tj : a.Target_JN_Tasks__r){
                if(tj.Monthly__c){
                    decimal montask = monthlytask.get(a.id);
                    montask++;
                    monthlytask.put(a.Id,montask);
                }
                if(tj.Regular__c){
                  decimal regtask = regulartask.get(a.id);
                    regtask++;
                    regulartask.put(a.Id,regtask);
                }
            }
        }
        for(Target__c a : at){
            a.Unique_Account_Completed__c = a.Accounts__r.size();
            a.Unique_Connects_Completed__c = monthlytask.get(a.id);
            a.Free_Trail_Completed__c = a.Proposal_Line_Items__r.size();
            a.Demonstration_Completed__c = a.Activities__r.size();
            a.Unique_Opportunity_Completed__c = a.Opportunities__r.size();
            a.New_Call_Meeting_Completed__c = regulartask.get(a.id);
            decimal createdtot = 0.00;
            decimal wontot = 0.00;
            if(a.Opportunities__r.size()>0)
            for(Opportunity__c createdval : a.Opportunities__r){
                createdtot = createdtot + createdval.Amount__c;
            }
            a.Opportunity_Created_Achieved__c = createdtot;
            if(a.Opportunities1__r.size()>0)
            for(Opportunity__c wonval : a.Opportunities1__r){
                //wontot = wontot + wonval.Expected_Revenue__c;
                if(wonval.Actual_Revenue__c==null){
                wontot = wontot + 0;
                }
                if(wonval.Actual_Revenue__c!=null){
                wontot = wontot + wonval.Actual_Revenue__c;
                }
            
            }
            a.Opportunity_Won_Achieved__c = wontot;
        }
        //update at;
                Database.SaveResult[] atupdate = Database.update(at, false);

        lrt.LRT__c = system.now();
        update lrt;
                

    }
}