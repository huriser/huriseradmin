@isTest public class ContactHandlerTest{

    @testSetup static void testSetup(){
        Account acc = new Account(Name = 'Test Account');
        Database.insert(acc);

        Contact con = new Contact(LastName = 'TestCon');
        con.AccountId = acc.Id;
        con.Active__c = true;
        Database.insert(con);
    }

    @isTest public static void test1(){
        test.startTest();
        Contact con = [SELECT Id FROM Contact WHERE LastName='TestCon'];
        Account acc = [SELECT Id,Active_Contacts__c FROM Account WHERE Name = 'Test Account'];
        con.Phone='12345';
        update con;
        test.stopTest();

        System.assert(acc.Active_Contacts__c==1);

    }
    @isTest public static void test2(){
        test.startTest();
        Contact con = [SELECT Id FROM Contact WHERE LastName='TestCon'];
        Delete con;
        Account acc = [SELECT Id,Active_Contacts__c FROM Account WHERE Name = 'Test Account'];
        
        
        test.stopTest();

        System.assert(acc.Active_Contacts__c==0);

    }
}