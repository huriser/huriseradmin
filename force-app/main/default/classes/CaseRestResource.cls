@RestResource(urlMapping='/CaseManagement/*')
global with sharing class CaseRestResource {

  
    @HttpGet
    global static Case doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case result = [SELECT Id, Subject, Status, Origin, Priority FROM Case WHERE Id = :caseId];
        return result;
        //services/apexrest/CaseManagement/500Dn000003T3sAIAS kullanarak workbench'te sorgula
    }
    @HttpPost
    global static String doPost(String subject, //post=create, put=upsert, patch=update
        String status, String origin, String priority) {
        Case newCase = new Case();
        newCase.subject= subject;
        newCase.status= status;
        newCase.origin= origin;
        newCase.priority= priority;
        insert newCase;
        return newCase.Id;
       
        /*{   //workbench
        "subject" : "This case was created using workbench",
        "status" : "New",
        "origin" : "Phone",
        "priority" : "Low"
      }
        */
    }
    @HttpPut
    global static String doPut(String subject, String status,
        String origin, String priority, String Id) {
        Case upsertCase = new Case(
                Id=id,
                Subject=subject,
                Status=status,
                Origin=origin,
                Priority=priority);
        
        upsert upsertCase;
       
        return upsertCase.Id;
        /*{ 
    "subject" : "This case was created using workbench",
    "status" : "Working",
    "origin" : "Web",
    "priority" : "Low"
    "id" : "500Dn00000448ntIAA"
 }
        */
    }
    @HttpDelete
    global static String deleteCase() {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case result = [SELECT Id FROM Case WHERE Id = :caseId];
        delete result;
        return result.Id;
        
    }
  

}