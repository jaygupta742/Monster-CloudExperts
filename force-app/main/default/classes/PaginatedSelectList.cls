public with sharing class PaginatedSelectList {
   /*   private List<Product__c> selectList=new List<Product__c>();
      private final Integer SUB_LIST_SIZE=1000;
      //Returns total numbers of items.
      public Integer getSize(){
            return selectList.size();
      }
      //Add SelectOption.
      public void add(Product__c so){
                  selectList.add(so);
      }
      //Gets SelectOption at given index.
      public Product__c get(Integer index){
            if(index>-1 && index<getSize()){
                  return selectList.get(index);
            }else{
                  return null;
            }    
      }
      //Removes SelectOption at given index
      public void remove(Integer index){
            if(index>-1 && index<getSize()){
                  selectList.remove(index);
            }    
      }

      public void clear(){
            selectList.clear();
      }

      public List<Product__c> getSelectList(){
            return selectList;
      }

      //Gets Select Options for the given start and end index both are inclusive.
      public List<Product__c> getSubList(Integer startIndex,Integer endIndex){
            List<Product__c> subList=new List<Product__c>();
            if(startIndex>-1 && startIndex<selectList.size()&& endIndex>-1 && endIndex<selectList.size()&&startIndex<=endIndex){
                  for(Integer i=startIndex;i<=endIndex;i++){
                        subList.add(get(i));
                  }
            }
            return subList;
      }
      //Gets Nth sub list by dividing the main list in sublists of SUB_LIST_SIZE(1000 elements).
      public List<Product__c>getNthSubList(Integer index){
            Integer subListCount=(Integer)(selectList.size()/SUB_LIST_SIZE);
            if(Math.mod(selectList.size(),SUB_LIST_SIZE)>0) subListCount++;
            if(index>=0 && index<=subListCount){
                  Integer startIndex=index*SUB_LIST_SIZE;
                  Integer endIndex=index*SUB_LIST_SIZE+(SUB_LIST_SIZE-1);
                  if(endIndex>=selectList.size())endIndex=selectList.size()-1;
                  return getSubList(startIndex,endIndex);
            }else{
                  return new List<Product__c>();
            }
      }
      //Gets sublist for given index.

      public List<Product__c>get0(){
            return getNthSubList(0);
      }
      public List<Product__c>get1(){
            return getNthSubList(1);
      }
      public List<Product__c>get2(){
            return getNthSubList(2);
      }
      public List<Product__c>get3(){
            return getNthSubList(3);
      }
      public List<Product__c>get4(){
            return getNthSubList(4);
      }
      public List<Product__c>get5(){
            return getNthSubList(5);
      }
      public List<Product__c>get6(){
            return getNthSubList(6);
      }
      public List<Product__c>get7(){
            return getNthSubList(7);
      }
      public List<Product__c>get8(){
            return getNthSubList(8);
      }
      public List<Product__c>get9(){
            return getNthSubList(9);
      }
      public List<Product__c>get10(){
            return getNthSubList(10);
      }
      public List<Product__c>get11(){
            return getNthSubList(11);
      }
      public List<Product__c>get12(){
            return getNthSubList(12);
      }
      public List<Product__c>get13(){
            return getNthSubList(13);
      }
      public List<Product__c>get14(){
            return getNthSubList(14);
      }
      public List<Product__c>get15(){
            return getNthSubList(15);
      }
      public List<Product__c>get16(){
            return getNthSubList(16);
      }
      public List<Product__c>get17(){
            return getNthSubList(17);
      }
      public List<Product__c>get18(){
            return getNthSubList(18);
      }
      public List<Product__c>get19(){
            return getNthSubList(19);
      }*/
}