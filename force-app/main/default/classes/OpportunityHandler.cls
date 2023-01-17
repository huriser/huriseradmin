public with sharing class OpportunityHandler {
    public static void checkOpportunity(List<Opportunity> oppList, Map<Id,Opportunity> oppOldMap) {
       
            List<Task> taskList = new List<Task>();

                for(Opportunity w:oppList){
                    if(w.StageName=='Closed Won' && 
                    oppOldMap.get(w.Id).StageName!='Closed Won'){

                    Task newTask=new Task(Subject='Follow Up Task',
                    ActivityDate=w.CloseDate.addMonths(1),
                    WhatId=w.Id,
                    OwnerId=w.OwnerId);
                    

                    taskList.add(newTask);                      
                }
               }
            if(taskList.size()>0){
               insert taskList;
            }

    
}
}