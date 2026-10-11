/*Created By : Abdul Aziz 
Created Date : 6-apr-2023
Description : Batch Class to update Account Team Member's Status to Inactive if user is deactivated
Dependency : BatchAccountTeamMember
*/

global class BatchAccountTeamMemberScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        BatchAccountTeamMember b = new BatchAccountTeamMember(); 
        Database.executeBatch(b);
    }
}