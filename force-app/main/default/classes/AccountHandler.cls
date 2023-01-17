public class AccountHandler {
    public static void createOPP(List<Account> newList){
        
    List<Opportunity> oppList = new List<Opportunity>();
    
    // Get the related opportunities for the accounts in this trigger
    List<Account> acctsWithOpps = [SELECT Id, Name FROM Account 
                                   WHERE Id IN : newList AND Id NOT IN(SELECT AccountId FROM Opportunity)];
        
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate through each account.
    for(Account acc : acctsWithOpps) { //query'i for-each parentezine içine taşıyabiliriz....(not body)
        
        // Check if the account already has a related opportunity.
       
            // If it doesn't, add a default opportunity
            oppList.add(new Opportunity(Name=acc.Name + ' Opportunity',
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acc.Id));
                 
    }
    if (oppList.size() != 0) {
        insert oppList;
  }
 }
   
}