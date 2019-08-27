trigger DuplicatePatient on Patient__c (before insert) {
	List <Patient__c> patientList = [SELECT Name From Patient__c];
    for (Patient__c iter:patientList) {
        if (iter.Name == Trigger.new[0].Name) {
            Trigger.new[0].Name.addError('Patient with the same name already exists!');
        }
    }
}