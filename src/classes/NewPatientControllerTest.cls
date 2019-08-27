@ISTest
private class NewPatientControllerTest {
	
    @IsTest static void NewPatientControllerTest1() {
        NewPatientController patientCont = new NewPatientController();
        Patient__c patient = new Patient__c(Name = 'Jordan');
        insert patient;
        Patient__c patient1 = new Patient__c(Name = 'Jordan');
        List<Database.SaveResult> result = Database.insert(new List<Patient__c> {patient1}, false);
    }
}