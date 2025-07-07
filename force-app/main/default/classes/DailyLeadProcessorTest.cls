@IsTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 * * ?';
    @IsTest
    static void testScheduledJob() {

        List<Lead> leadsNoLeadSource = new List<Lead>();
        for (Integer i=0; i<200; i++) {
            Lead l = new Lead(
                LastName = 'Lead ' + i,
                Company  = 'OpenAI',
                LeadSource = null
            );
            leadsNoLeadSource.add(l);
        }
        insert leadsNoLeadSource;

        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new DailyLeadProcessor());
        List<Lead> leadsOriginal = [SELECT Id, LeadSource 
            FROM Lead
            WHERE LeadSource  = null ];
        System.assertEquals(200, leadsOriginal.size());
        Test.stopTest();
        List<Lead> leadsDreamforce = [SELECT Id, LeadSource 
            FROM Lead
            WHERE LeadSource  = 'Dreamforce' ];
        System.assertEquals(200, leadsDreamforce.size());
    }
}