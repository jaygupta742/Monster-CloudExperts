@isTest
public class MakeCountZeroSchedulerTest {
    @isTest
    public static void test_method() {
        String cronexp = '0 0 1 * * ? *';
        System.schedule('Test Schdeule', cronexp, new MakeCountZeroScheduler());
    }
}