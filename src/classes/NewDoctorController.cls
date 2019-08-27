public class NewDoctorController {
    
    public Doctor__c doctorName{get;set;}
    public Doctor__c workingHoursStart{get;set;}
    public Doctor__c workingHoursEnd{get;set;}
    public PageReference acctPage{get;set;}
    
    
    public NewDoctorController() {
        doctorName = new Doctor__c();
        workingHoursStart = new Doctor__c();
        workingHoursEnd = new Doctor__c();
        acctPage = new PageReference('https://c.ap15.visual.force.com/apex/AppointmentsTable?sfdc.tabName=01r2v000000mCG6');
    }
    
     public PageReference close() {
        acctPage.setRedirect(true);
        return acctPage;
    }
    
    public PageReference addDoctor(){
        try {
        	Doctor__c newDoctor = new Doctor__c(Name = doctorName.Name,Working_Hours_Start__c = workingHoursStart.Working_Hours_Start__c,
                                           Workng_Hours_End__c = workingHoursEnd.Workng_Hours_End__c);
        	insert newDoctor;
        	acctPage.setRedirect(true);
            
        } catch(Exception e) {
            
            return null;
        }
        return acctPage;
    }
}