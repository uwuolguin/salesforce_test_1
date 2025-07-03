public class ContactSearch {
    public static Contact[] searchForContacts(String lastName, String postalCode) {
        Contact[] contacts = [
            SELECT Id, Name
            FROM Contact
            WHERE LastName = :lastName
            AND MailingPostalCode = :postalCode
        ];
        return contacts;
    }
}
