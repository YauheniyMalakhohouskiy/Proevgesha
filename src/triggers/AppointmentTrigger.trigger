trigger AppointmentTrigger on Appointment__c (before insert,before update) {
    
    LIST <Appointment__c> appointmentList = [SELECT Appointment_Date__c,Duration_in__c FROM Appointment__c 
                                             WHERE Doctor__c = :Trigger.new[0].Doctor__c 
                                             AND Appointment_Date__c <= :Trigger.new[0].Appointment_Date__c]; 
    
    if ( appointmentList.isEmpty() == FALSE ) {
        LIST <Appointment__c> durationList = [SELECT Duration_in__c FROM Appointment__c 
                                             WHERE Doctor__c = :Trigger.new[0].Doctor__c 
                                             AND Appointment_Date__c <= :Trigger.new[0].Appointment_Date__c];
        for ( integer i = 0; i < appointmentList.size();i++ )  {
            DateTime dd = DateTime.valueOf(appointmentList[i].Appointment_Date__c).addMinutes(Integer.valueOf(appointmentList[i].Duration_in__c));
           
            if (((DateTime.valueOf(Trigger.new[0].Appointment_Date__c) <= dd)
               && DateTime.valueOf(Trigger.new[0].Appointment_Date__c) >= DateTime.valueOf(appointmentList[i].Appointment_Date__c)) 
               || DateTime.valueOf(Trigger.new[0].Appointment_Date__c) == DateTime.valueOf(appointmentList[i].Appointment_Date__c) ) {
             Trigger.new[0].Appointment_Date__c.addError('Doctor is busy');
            }
        }
        
    }
}