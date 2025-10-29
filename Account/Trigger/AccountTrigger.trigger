trigger AccountTrigger on Account (before insert,before update, after insert,after update,Before delete) {
  Trigger_Setting__mdt triggerSettingMetadata = [SELECT Account_Trigger_IsActive__c FROM Trigger_Setting__mdt WHERE DeveloperName = 'Default'];
    
    if(triggerSettingMetadata.Account_Trigger_IsActive__c){
         if (trigger.isbefore && trigger.IsInsert) {
                AccountTriggerHelper.formatPhone(trigger.New); 
                AccountTriggerHelper.populateEmailDomain(trigger.New);
                AccountTriggerHelper.checkBusinessDomain(trigger.New);
             AccountTriggerHelper.inheritEntitlement(trigger.New);
            // AccountTriggerHelper.hasEntitlementfromParent(trigger.New, trigger.oldMap);
            }
        if (trigger.isbefore && Trigger.IsUpdate) {
                AccountTriggerHelper.formatPhone(trigger.New); 
                AccountTriggerHelper.populateEmailDomain(trigger.New);
            	AccountTriggerHelper.populateEmailDomainfromContact(trigger.New);
            	AccountTriggerHelper.checkBusinessDomain(trigger.New);
            	AccountTriggerHelper.preventOverwritingValuesfromSkyvia(trigger.New, trigger.oldMap);
           // AccountTriggerHelper.hasEntitlementfromParent(trigger.New, trigger.oldMap);
            }
        if (trigger.isAfter && Trigger.IsUpdate) {
            AccountTriggerHelper.hasEntitlementfromParent(trigger.New, trigger.oldMap);
        }
    }
}