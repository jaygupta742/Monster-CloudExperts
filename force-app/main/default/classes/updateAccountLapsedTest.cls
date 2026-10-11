@isTest(SeeAllData = true) public class updateAccountLapsedTest {
    @isTest public static void startTest(){
        updateAccountLapsed BAD = new updateAccountLapsed();
        DataBase.executeBatch(BAD,200); 
    }
}