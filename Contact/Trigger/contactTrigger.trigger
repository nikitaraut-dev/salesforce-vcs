trigger contactTrigger on contact (before insert,before update, after insert,after update,Before delete) 
{ 
    Trigger_Setting__mdt triggerSettingMetadata = [SELECT Contact_Trigger_IsActive__c FROM Trigger_Setting__mdt WHERE DeveloperName = 'Default'];
    
    if(triggerSettingMetadata.Contact_Trigger_IsActive__c){
        if (trigger.IsInsert || Trigger.IsUpdate){
            if(trigger.isafter ){
                if(trigger.IsInsert){
                    contactTriggerHelper.associateAccountOnCreate(trigger.new);
                    contactTriggerHelper.handleCreate(trigger.new);
                    
                   }
                system.debug('flag value : ' + contactTriggerHelper.flag);
                if(trigger.IsUpdate && contactTriggerHelper.flag){
                   contactTriggerHelper.handleUpdate(trigger.new); 
                     contactTriggerHelper.associateAccountOnUpdate(trigger.new);
                }                
            }
            // contactTriggerHelper.handleBulkUploadProspectOnUpdate();
            
            
            if(trigger.isbefore){
             // contactTriggerHelper.updateQueueableFlag(trigger.New);
                contactTriggerHelper.handleBulkUploadProspectOnCreate(trigger.new);
                ContactTriggerHelper.formatPhone(trigger.New); 
                ContactTriggerHelper.associateAccountBefore(trigger.New);
                 if(trigger.IsUpdate){
                       contactTriggerHelper.preventOverwritingValuesfromSkyvia(trigger.new, trigger.oldMap);
                
                 }
            }
        }
        
    }
}