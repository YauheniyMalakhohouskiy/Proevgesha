trigger TimeControl on Appointment__c (before insert) {
	List <Doctor__c> appList = [SELECT Workng_Hours_End__c,Working_Hours_Start__c 
                                FROM Doctor__c where ID = :Trigger.new[0].Doctor__c];
    
    Datetime yourDateTime = Trigger.new[0].Appointment_Date__c;
    Time timeFrom = Time.newInstance(yourDateTime.hour(),yourDateTime.minute(),
                                     yourDateTime.second(), yourDateTime.millisecond());
    if (timeFrom < appList[0].Working_Hours_Start__c || timeFrom > appList[0].Workng_Hours_End__c) {
        Trigger.new[0].Appointment_Date__c.addError('Doctor doesnt work at this time!');
    }
    
    if (Trigger.new[0].Appointment_Date__c <=System.now()) {
        Trigger.new[0].Appointment_Date__c.addError('We cant live in past');
    }
    
    
}