@isTest(SeeAllData = true) public class deleteAccountTeamMemberBatchTest {
    @isTest public static void startTest(){
        deleteAccountTeamMemberBatch BAD = new deleteAccountTeamMemberBatch();
        DataBase.executeBatch(BAD,200); 
    }
}