@isTest(SeeAllData = true) public class deleteEmailMessageTest {
    @isTest public static void startTest(){
        deleteEmailMessage BAD = new deleteEmailMessage();
        DataBase.executeBatch(BAD,200); 
    }
}