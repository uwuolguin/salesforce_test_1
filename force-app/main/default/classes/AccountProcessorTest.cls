@IsTest
public class AccountProcessorTest {
    @IsTest
    static void testCountContacts() {

        Account acc = new Account(Name = 'Test Account');
        insert acc;
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 3; i++) {
            contacts.add(new Contact(
                FirstName = 'First' + i,
                LastName = 'Last' + i,
                AccountId = acc.Id
            ));
        }
        insert contacts;

        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc.Id});
        Test.stopTest();

        Account updatedAcc = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(3, updatedAcc.Number_Of_Contacts__c, 'The Number Of Contacts should be 3.');
    }

    @IsTest
    static void testCountContactsWithNoContacts() {
        Account acc = new Account(Name = 'No Contacts Account');
        insert acc;

        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc.Id});
        Test.stopTest();
        Account updatedAcc = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, updatedAcc.Number_Of_Contacts__c, 'The Number Of Contacts should be 0.');
    }
    @IsTest
    static void testCountContactsWithNoContactsInput() {

        Test.startTest();
        AccountProcessor.countContacts(null);         
        AccountProcessor.countContacts(new List<Id>());
        Test.stopTest();
    }
}
