@istest
public class fromJSON_test {
@istest
    public static void testdata(){
    fromJSON ff=new fromJSON();
        list<fromJSON.customerRecord> ftr=new list<fromJSON.customerRecord>();
        fromJSON.customerRecord frc=new fromJSON.customerRecord();
        frc.lead_score='5';
        frc.phone1='8909786789';
        ftr.add(frc);
        ff.customerRecord=ftr;
    }
}