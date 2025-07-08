@isTest
private class TestRestrictContactByName {

    // Test inserting a Contact with a valid LastName (should succeed)
    @isTest
    static void testInsertValidContact() {
        Contact c = new Contact(LastName = 'Winter');
        Test.startTest();
        try {
            insert c;
            // Query to verify the contact was inserted
            List<Contact> contacts = [SELECT Id, LastName FROM Contact WHERE LastName = 'Winter'];
            System.assertEquals(1, contacts.size(), 'Contact with LastName Winter should be inserted');
        } catch (DmlException e) {
            System.assert(false, 'Insert should succeed but failed with: ' + e.getMessage());
        }
        Test.stopTest();
    }

    // Test inserting a Contact with an invalid LastName (should fail)
    @isTest
    static void testInsertInvalidContact() {
        Contact c = new Contact(LastName = 'INVALIDNAME');
        Test.startTest();
        try {
            insert c;
            System.assert(false, 'Expected DmlException due to addError, but insert succeeded.');
        } catch (DmlException e) {
            System.assert(
                e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'),
                'Expected addError message to appear but got: ' + e.getMessage()
            );
        }
        Test.stopTest();
    }
}
