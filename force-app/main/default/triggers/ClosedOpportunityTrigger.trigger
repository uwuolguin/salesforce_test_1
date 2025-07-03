trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> followUpTasks = new List<Task>();

    for (Opportunity opp : Trigger.new) {
        if (opp.StageName == 'Closed Won') {
            followUpTasks.add(new Task(
                Subject = 'Follow Up Test Task',
                WhatId = opp.Id
            ));
        }
    }
    if (!followUpTasks.isEmpty()) {
        insert followUpTasks;
    }
}
