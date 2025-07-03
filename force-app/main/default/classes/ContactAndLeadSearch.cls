public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String nameToSearch) {
        List<List<SObject>> searchResults = [FIND :nameToSearch IN NAME FIELDS RETURNING Contact(Id, FirstName, LastName), Lead(Id, FirstName, LastName)];
        return searchResults;
    }
}
