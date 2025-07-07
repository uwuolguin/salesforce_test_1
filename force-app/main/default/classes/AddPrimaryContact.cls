public class AddPrimaryContact implements Queueable {

    private Contact baseContact;
    private String stateAbbreviation;

    public AddPrimaryContact(Contact baseContact, String stateAbbreviation) {
        this.baseContact = baseContact;
        this.stateAbbreviation = stateAbbreviation;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [
            SELECT Id,BillingState
            FROM Account
            WHERE BillingState = :stateAbbreviation
            LIMIT 200
        ];

        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : accounts) {
            Contact clonedContact = baseContact.clone(false, true, false, false);
            clonedContact.AccountId = acc.Id;
            contactsToInsert.add(clonedContact);
        }

        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}
