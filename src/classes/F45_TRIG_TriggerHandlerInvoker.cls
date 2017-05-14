public with sharing class F45_TRIG_TriggerHandlerInvoker {
    F45_TRIG_TriggerHandlerIntf triggerHandler;
    
    public F45_TRIG_TriggerHandlerInvoker(F45_TRIG_TriggerHandlerIntf triggerHandler) {
    	this.triggerHandler = triggerHandler;
    } 
    
    public void invoke(F45_TRIG_TriggerWrapper triggerWrapper) {
        if (triggerWrapper.isBefore && triggerWrapper.isInsert) {
        	 this.triggerHandler.onBeforeInsert(triggerWrapper.newSObjectList); 					                           
        } 
        else if (triggerWrapper.isAfter  && triggerWrapper.isInsert) { 
        	this.triggerHandler.onAfterInsert(triggerWrapper.newSObjectByIdMap);                               
        } 
        else if (triggerWrapper.isBefore && triggerWrapper.isUpdate) { 
        	this.triggerHandler.onBeforeUpdate(triggerWrapper.newSObjectByIdMap, triggerWrapper.oldSObjectByIdMap);
        } 
        else if (triggerWrapper.isAfter  && triggerWrapper.isUpdate) { 
        	this.triggerHandler.onAfterUpdate(triggerWrapper.newSObjectByIdMap, triggerWrapper.oldSObjectByIdMap);  
        } 
        else if (triggerWrapper.isBefore && triggerWrapper.isDelete) { 
        	this.triggerHandler.onBeforeDelete(triggerWrapper.oldSObjectByIdMap);                              
        } 
        else if (triggerWrapper.isAfter  && triggerWrapper.isDelete) { 
        	this.triggerHandler.onAfterDelete(triggerWrapper.oldSObjectByIdMap);                               
        } 
        else if (triggerWrapper.isUndelete) { 
        	this.triggerHandler.onAfterUndelete(triggerWrapper.newSObjectByIdMap);                             
        }
    }
}