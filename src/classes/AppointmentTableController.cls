public with sharing class AppointmentTableController {
    
	Public Integer size{get;set;} 
    Public Integer noOfRecords{get; set;} 
    public List<Patient__c> patientList{get;set;}
    public List<SelectOption> patientSelectOptionList {get;set;}
    public String patientID{get;set;}
    public String doctorID{get;set;}
    public Doctor__c schedule{get;set;}
    public Appointment__c duration{get;set;}
    public List<Doctor__c> doctorList {get;set;}
    public List<SelectOption> doctorSelectOptionList {get;set;}
    public List<Appointment__c> appointDates {get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    public Time startWorkTime{get;set;}
    public Time endWorkTime{get;set;}
    public Appointment__c dateFromInput{get;set;}
    public Integer pageNumber{get;set;}
    
    public AppointmentTableController() {
        doctorList = [SELECT Name,Working_Hours_Start__c,Workng_Hours_End__c FROM Doctor__c ORDER BY Name ASC];
        if(!doctorList.isEmpty()) {
        	doctorID = doctorList.isEmpty()==FALSE ? doctorList[0].Name : NULL;
        	patientList = [SELECT Name FROM Patient__c ORDER BY Name ASC];
        	patientID = patientList.isEmpty()==FALSE ? doctorList[0].Name : NULL;
        	dateFromInput = new Appointment__c();
        	duration = new Appointment__c();
        	setDoctorSelectOptionList();
        	setPatientSelectOptionList();
        	setAppointmentDates();
            getPageNumber();
            navigate();
        } else {
            pageNumber = 0;
            size = 0;
            noOfRecords = 0;
        }
       
        
    }
    
   public PageReference addNewDoctor() {
        PageReference acctPage = new PageReference('https://c.ap15.visual.force.com/apex/NewDoctor?sfdc.tabName=01r2v000000mDcO');
        acctPage.setRedirect(true);
        return acctPage;
    }
    
    public PageReference addNewPatient() {
        PageReference acctPage = new PageReference('https://c.ap15.visual.force.com/apex/NewPatient?sfdc.tabName=01r2v000000mDto');
        acctPage.setRedirect(true);
        return acctPage;
    }
    
    public void addNewAppointment() {
        try {
            Doctor__c doctorRelation = new Doctor__c(Name = doctorID);
            Patient__c patientRelation = new Patient__c(Name = patientID);
            
        	Appointment__c newAppointment = new Appointment__c(Appointment_Date__c = dateFromInput.Appointment_Date__c,Doctor__r = doctorRelation,
                                                   Patient__r = patientRelation,
                                              	   Duration_in__c = duration.Duration_in__c
                                                   );
            insert newAppointment;
            setAppointmentDates();
        } catch(DmlException e) {

        }
        
    }
    
   
    public void setPatientSelectOptionList() {
        patientSelectOptionList = new List<SelectOption>();
        for (Patient__c patient: patientList) {
            patientSelectOptionList.add(new SelectOption(patient.Name,patient.Name));
        }
    }
    
     public void setDoctorSelectOptionList() {
        doctorSelectOptionList = new List<SelectOption>();
        for (Doctor__c doctor: doctorList) {
            doctorSelectOptionList.add(new SelectOption(doctor.Name,doctor.Name));
        }
    }
    
    public void navigate() {
        appointDates = new List<Appointment__c>();
        appointDates = setCon.getRecords();
       
    }
    
    public void next() {
		setCon.next();
		navigate();
        getPageNumber();
	}
    
    public void last() {
		setCon.last();
		navigate();
        getPageNumber();
	}
    
    public void previous() {
		setCon.previous();
		navigate();
        getPageNumber();
	}
    
    public void first() {
		setCon.first();
		navigate();
        getPageNumber();
	}
    
    
    public void setAppointmentDates() {
        size = 20;
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                [SELECT Doctor__r.Name,Patient__r.Name,Appointment_Date__c,Duration_in__c,Doctor__r.Working_Hours_Start__c,Doctor__r.Workng_Hours_End__c
                 FROM Appointment__c WHERE Doctor__r.Name = :doctorID  ORDER BY Appointment_Date__c ASC]));
        setCon.setPageSize(size);
        getPageNumber();
        schedule = [SELECT Working_Hours_Start__c,Workng_Hours_End__c FROM Doctor__c WHERE Name = :doctorID];
        noOfRecords = setCon.getResultSize();
        navigate();
    }
    
    public void getPageNumber() {
        pageNumber = setCon.getPageNumber();
        
    }
    
   
   

    
}