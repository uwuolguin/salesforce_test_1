public with sharing class A2 {
  public static List<Account> getAllActiveAccounts() {
    return [SELECT Id, Name, Active__c FROM Account WHERE Active__c = 'Yes' WITH SECURITY_ENFORCED];
  }
}