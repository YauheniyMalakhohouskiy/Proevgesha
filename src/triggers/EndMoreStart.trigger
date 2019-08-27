trigger EndMoreStart on Doctor__c (before insert) {
	
    if (Trigger.new[0].Workng_Hours_End__c < Trigger.new[0].Working_Hours_Start__c) {
        Trigger.new[0].addError('End > Start');
    }
    
}