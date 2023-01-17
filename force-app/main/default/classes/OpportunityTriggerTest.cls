@isTest
public class OpportunityTriggerTest {

    @testSetup static void setup() {
        Account acc = new Account(Name ='Test Account');
        Database.insert(acc);
        
        Opportunity opp = new Opportunity();
        opp.Name ='Test Opp';
        opp.StageName ='Prospecting';
        opp.CloseDate =Date.today().addMonths(1);
        opp.AccountId = acc.Id;
        Database.insert(opp);   
    }

    @isTest static void oppTest(){
        test.startTest();
        Opportunity opp =[SELECT Id FROM Opportunity WHERE Name='Test Opp'];
        opp.StageName='Closed Won';
        update opp;
        Task oppTask=[SELECT ID, WhatId FROM Task WHERE WhatId=:opp.Id];
        test.stopTest();

        system.assert(oppTask.WhatId==opp.Id, 'Message');
    }

}