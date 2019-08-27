@IsTest
private class AppointmentTriggerTest {
	
    @IsTest static void AppointmentTriggerTest1() {
        Doctor__c doctor = new Doctor__c(
        	Name = 'Sir', Working_Hours_Start__c = Time.newInstance(10, 00, 00, 000),
            Workng_Hours_End__c = Time.newInstance(18, 00, 00, 000)
        );
        insert doctor;
        Patient__c patient = new Patient__c(Name = 'Jordan');
        insert patient;
        List<Doctor__c> doctorList = [SELECT Name, ID FROM Doctor__c];
        List<Patient__c> patientList = [SELECT Name, ID FROM Patient__c];
        Appointment__c app = new Appointment__c(Appointment_Date__c = Datetime.newInstance(2019, 8, 14, 11, 15, 00),Doctor__c = doctorList[0].ID,Duration_in__c = 10,
                                               Patient__c = patientList[0].ID);
        insert app;
        Appointment__c app1 = new Appointment__c(Appointment_Date__c = Datetime.newInstance(2019, 8, 14, 11, 15, 00),Doctor__c = doctorList[0].ID,Duration_in__c = 10,
                                               Patient__c = patientList[0].ID);
        List<Database.SaveResult> result = Database.insert(new List<Appointment__c> {app1}, false);
    }
}