public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> leadsOriginal = [SELECT Id, LeadSource 
            FROM Lead
            WHERE LeadSource  = null limit 200];
        List<Lead> leadsToUpdate = new List<Lead>();
        for (Lead lead : leadsOriginal) {
                lead.LeadSource = 'Dreamforce';
                leadsToUpdate.add(lead);
        }
        update leadsToUpdate;
    }

}