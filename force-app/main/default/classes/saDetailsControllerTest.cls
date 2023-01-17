@isTest
class saDetailsControllerTest {
   
  @TestSetup
  static void makeData(){
    Contact con = new Contact(LastName='TestSupervisor');
    insert con;
    List<SA_Detail_TR1__c> saList = new List<SA_Detail_TR1__c>();

    for(Integer i=0; i<5; i++){
        SA_Detail_TR1__c newSA = new SA_Detail_TR1__c();
        newSA.Name_TR1__c = 'TestSA' + i;
        newSA.Supervisor_TR1__c=con.Id;
        saList.add(newSA);


    }
    insert saList;
    
  }
  @isTest static void test1(){
    test.startTest();
    List<SA_Detail_TR1__c> checkList = saDetailsController.getSaDetails();
    test.stopTest();
    System.assert(checkList.size()==5, 'Test basarisiz');

  }
  @isTest static void test2(){
    test.startTest();
    List<SA_Detail_TR1__c> checkList = saDetailsController.findSaDetails('Test');
    test.stopTest();
    System.assert(checkList.size()==5, 'Test basarisiz');

  }
}