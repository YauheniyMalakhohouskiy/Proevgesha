trigger Duplicate on Doctor__c (before insert) {
	List <Doctor__c> doctorList = [SELECT Name From Doctor__c];
    for (Doctor__c iter:doctorList) {
        if (iter.Name == Trigger.new[0].Name) {
            Trigger.new[0].Name.addError('A doctor with that name already exists!');
        }
    }
    
}