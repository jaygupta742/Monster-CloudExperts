@Istest
public class UserAccountCountSchedulerTest {
	@Istest
    Public static void myPAOAtmeth(){
      //User u=[select id,name from user];
        System.schedule('UserAccountCountScheduler', '0 0 * * * ? *', New UserAccountCountScheduler());
    }
}