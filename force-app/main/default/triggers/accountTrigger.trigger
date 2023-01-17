trigger accountTrigger on Account (after insert, after update) {
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
         AccountHandler.createOPP(Trigger.new); 
  }
}