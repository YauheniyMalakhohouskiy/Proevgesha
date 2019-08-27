public class NewPatientController {
	
    public Patient__c namePatient {get;set;}
    public NewPatientController() {
        namePatient = new Patient__c();
    }
    
    public PageReference addPatient() {
        try {
        	Patient__c newPatient = new Patient__c(Name = namePatient.Name);
        	insert newPatient;
        } catch(DmlException e) {
            return null;
        }
        PageReference acctPage = new PageReference('https://c.ap15.visual.force.com/apex/AppointmentsTable?sfdc.tabName=01r2v000000mCG6');
        acctPage.setRedirect(true);
        return acctPage;
        
    } 
    
    public PageReference close() {
        PageReference acctPage = new PageReference('https://c.ap15.visual.force.com/apex/AppointmentsTable?sfdc.tabName=01r2v000000mCG6');
        acctPage.setRedirect(true);
        return acctPage;
    }
    
    
}