@IsTEst
private class NewDoctorControllerTest {
	
    @IsTest static void NewDoctorControllerTest1() {
      	NewDoctorController docControl = new NewDoctorController();
        Doctor__c doctor = new Doctor__c(
        	Name = 'Sir', Working_Hours_Start__c = Time.newInstance(10, 00, 00, 000),
            Workng_Hours_End__c = Time.newInstance(18, 00, 00, 000)
        );
        insert doctor;
         Doctor__c doctor1 = new Doctor__c(
        	Name = 'Sir', Working_Hours_Start__c = Time.newInstance(10, 00, 00, 000),
            Workng_Hours_End__c = Time.newInstance(18, 00, 00, 000)
        );
        List<Database.SaveResult> result = Database.insert(new List<Doctor__c> {doctor1}, false);
    }
}