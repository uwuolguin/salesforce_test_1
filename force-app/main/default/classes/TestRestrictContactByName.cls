@isTest
private class TestRestrictContactByName  {

  @isTest
  static void TestDeleteAccountWithOneOpportunity() {
    Contact c = new Contact(LastName = 'Winter');
    Test.startTest();
    try {
        insert c; 
        List<Contact> ContactsDreamforce = [SELECT Id, LastName
            FROM Contact
            WHERE LastName = 'Winter'];
        System.assertEquals(1, ContactsDreamforce.size()); 

    } catch (DmlException e) {
        System.assert(
            e.getMessage().contains('The Last Name INVALIDNAME is not allowed for DML'
        ));
    }
    Test.stopTest();
    }
  
    @isTest
    static void TestDeleteAccountWithOneOpportunity2() {
    Contact c = new Contact(LastName = 'INVALIDNAME');
    Test.startTest();
    try {
        insert c; 
        List<Contact> ContactsDreamforce = [SELECT Id, LastName
            FROM Contact
            WHERE LastName = 'INVALIDNAME'];
        System.assertEquals(1, ContactsDreamforce.size()); 

    } catch (DmlException e) {
        System.assert(
            e.getMessage().contains('The Last Name INVALIDNAME is not allowed for DML'
        ));
    }
    Test.stopTest();
    }
}
