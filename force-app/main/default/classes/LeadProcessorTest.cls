@isTest
private class LeadProcessorTest {
    @testSetup
static void setup() {
    List<Lead> leads = new List<Lead>();
    for (Integer i = 0; i < 10; i++) {
        leads.add(new Lead(
            LastName = 'Lead ' + i,
            Company = 'New York',
            LeadSource = 'USA'
        ));
    }
    insert leads;
    }
    @isTest static void test() {
        Test.startTest();
        LeadProcessor lp= new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();

        System.assertEquals(10, [select count() from lead where LeadSource= 'Dreamforce']);
    }
}