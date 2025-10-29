trigger LeadTrigger on Lead (before insert,after insert, before update, after update) {
	Trigger_Setting__mdt triggerSettingMetadata = [SELECT Lead_Trigger_IsActive__c FROM Trigger_Setting__mdt WHERE DeveloperName = 'Default'];
	if((trigger.isbefore|| Trigger.isafter) && (trigger.isInsert || trigger.isUpdate) && triggerSettingMetadata.Lead_Trigger_IsActive__c) {
		System.debug('isbefore');
        if( Trigger.isbefore && trigger.isInsert){
            LeadHelper.unqualifyLeadOnCreate(Trigger.new);   
           }
           
           if( Trigger.isbefore && trigger.isUpdate){
            //LeadHelper.unqualifyLeadOnUpdate(Trigger.new, trigger.oldMap);
                     LeadHelper.unqualifyLeadOnCreate(Trigger.new);   
      
           }
        if(Trigger.isafter && LeadHelper.flag){
            LeadHelper.associateContact(Trigger.NewMap);
        }
        if( Trigger.isafter && trigger.isInsert && !Test.isRunningTest() ){
         LeadHelper.updateNotesOnLead(Trigger.new);   
        }
        
	}
}