@IsTest
private class AddPrimaryContactTest {

    @IsTest
    static void testAddPrimaryContactQueueable() {
        List<Account> accountsNY = new List<Account>();
        List<Account> accountsCA = new List<Account>();

        for (Integer i = 0; i < 50; i++) {
            accountsNY.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY'));
            accountsCA.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA'));
        }

        insert accountsNY;
        insert accountsCA;

        Contact baseContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'johndoe@example.com'
        );

        Test.startTest();
        AddPrimaryContact job = new AddPrimaryContact(baseContact, 'CA');
        System.enqueueJob(job);
        Test.stopTest();

        List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact];
        System.assertEquals(50, insertedContacts.size());

        Set<Id> caAccountIds = new Set<Id>();
        for (Account a : [SELECT Id FROM Account WHERE BillingState = 'CA']) {
            caAccountIds.add(a.Id);
        }

        for (Contact con : insertedContacts) {
            System.assert(caAccountIds.contains(con.AccountId), 'Contact is linked to an unexpected Account');
        }
    }
}
