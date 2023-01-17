@isTest public class AccountTriggerTest {

    @testSetup public static void testdata(){
        Account acc = new Account(Name='testAcc');
        insert acc;


    }
    @isTest 
    public static void test(){

        //Test.setCreateDate(opp.Id, DateTime.newInstance(2023,03,01));
        Test.startTest();
        Account acc = [SELECT Id FROM Account WHERE Name = 'testAcc'];
        //insert acc;
        List<Opportunity> opp = [SELECT Id FROM Opportunity WHERE AccountId =: acc.Id];
        Test.stopTest();
        System.assert(opp.size()>0);
       
        
    }
    
}