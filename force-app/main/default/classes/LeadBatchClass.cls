public  class LeadBatchClass implements Schedulable, Database.Batchable<sObject> {
    
    //Once Start methodu implement edilir
   public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead WHERE LeadSource = null');

   }

   //Ikinci olarak execute methodu implement edilir
   public void execute(Database.BatchableContext bc, List<Lead> leadList){
    for(Lead w : leadList){
        w.LeadSource = 'Manual';

    }
    update leadList;

   }

   //Son olarak Finish methodu implement edilir
   public void finish(Database.BatchableContext bc){
    System.debug('Update Success');

   }

   //Schedulable clas'i ayri yazabiliriz ama schedulable implemet edersek methodu burada da yazabiliriz
   public void execute(SchedulableContext scope){
    LeadBatchClass myBatch = new LeadBatchClass();
    Database.executeBatch(myBatch,200);

    //Anonymus windows'tan calistirilmasi
    //LeadBatchClass m = new LeadBatchClass();
   }
    
}