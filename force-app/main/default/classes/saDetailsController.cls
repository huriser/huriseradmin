public with sharing class saDetailsController {
    
    @AuraEnabled(Cacheable = true)
    public static List <SA_Detail_TR1__c> getSaDetails () {
        return [SELECT Id, Name_TR1__c, Experience_TR1__c, Customer_Handled_TR1__c, 
                Date_of_Joining_TR1__c, Location_TR1__Latitude__s, Location_TR1__Longitude__s FROM SA_Detail_TR1__c LIMIT 20];
                

    }
    
    @AuraEnabled(cacheable=true)
    public static List<SA_Detail_TR1__c> findSaDetails(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name_TR1__c, Experience_TR1__c, Customer_Handled_TR1__c, Date_of_Joining_TR1__c,Location_TR1__Latitude__s, Location_TR1__Longitude__s
            FROM SA_Detail_TR1__c
            WHERE Name_TR1__c LIKE :key
            WITH SECURITY_ENFORCED
            LIMIT 20
        ];
    }
}