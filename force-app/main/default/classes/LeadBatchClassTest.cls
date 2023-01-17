@isTest
public class LeadBatchClassTest {

    @TestSetup
    static void makeData(){

        List<Lead> leadList = new List<Lead>();
        

        for(Integer i=0; i<100; i++){
            Lead newLead = new Lead();
            newLead.LastName = 'Team1Test'+i;
            newLead.Company = 'TestCompany';
            leadList.add(newLead);
        }
        insert leadList;
        
    }
    @isTest static void batchTest(){
        Test.startTest();
        LeadBatchClass myBatch = new LeadBatchClass();
        Database.executeBatch(myBatch,200);
        Test.stopTest();
        System.assertEquals(100, [SELECT Count() FROM Lead WHERE LeadSource='Manual']);
    }

    @isTest static void scheduleTest(){
        Test.startTest();
        LeadBatchClass m = new LeadBatchClass();
        String sch = '0 0 23 * * ?';
        String jobID = System.schedule('LeadUpdateBatch', sch, m); 
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId]; 
        test.stopTest();
        System.assertEquals('2023-01-06 23:00:00', String.valueOf(ct.NextFireTime)); 

    }

}