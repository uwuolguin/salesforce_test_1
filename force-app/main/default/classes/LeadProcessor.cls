global class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {
    
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }

    global void execute(Database.BatchableContext BC, List<Lead> scope) {
        List<Lead> leadsToUpdate = new List<Lead>();

        for (Lead s : scope) {
            Lead l = s;
            l.LeadSource = 'Dreamforce';
            leadsToUpdate.add(l);
            recordsProcessed = recordsProcessed + 1;
        }

        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug(recordsProcessed + 'records processed');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }
}
