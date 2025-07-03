public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return;
        }
        Map<Id, Long> contactCountMap = new Map<Id, Long>();

        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) counter
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            contactCountMap.put((Id)ar.get('AccountId'), (Long)ar.get('counter'));
        }
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountIds) {
            Long count = contactCountMap.containsKey(accId) ? contactCountMap.get(accId) : 0;
            accountsToUpdate.add(new Account(
                Id = accId,
                Number_Of_Contacts__c = count
            ));
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
