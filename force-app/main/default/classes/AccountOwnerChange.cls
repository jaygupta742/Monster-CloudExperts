global class AccountOwnerChange {
    webservice static void ownerchange(List<string> acc,String uid){
        List<Account> la = new List<Account>();
        for(String ac : acc){
            Account a = new Account();
            a.id = ac;
            a.OwnerId = uid;
            la.add(a);
        }
        update la;
    }
}