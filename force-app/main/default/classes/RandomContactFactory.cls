public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String commonLastName) {
        List<Contact> contacts = new List<Contact>();
        
        for(Integer i = 0; i < numberOfContacts; i++) {
            Contact c = new Contact();
            c.FirstName = 'Test ' + i;
            c.LastName = commonLastName;
            contacts.add(c);
        }
        
        return contacts;
    }
}
