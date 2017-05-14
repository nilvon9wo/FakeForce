public with sharing virtual class F45_TRIG_AbstractTriggerHandler {
	public virtual void onBeforeInsert(List<SObject> newSObjectList) {}
    public virtual void onAfterInsert (Map<Id, SObject> newSObjectByIdMap) {}

    public virtual void onBeforeUpdate(Map<Id, SObject> newSObjectByIdMap, Map<Id, SObject> oldSObjectByIdMap) {}
    public virtual void onAfterUpdate (Map<Id, SObject> newSObjectByIdMap, Map<Id, SObject> oldSObjectByIdMap) {}

    public virtual void onBeforeDelete(Map<Id, SObject> oldSObjectByIdMap) {}
    public virtual void onAfterDelete (Map<Id, SObject> oldSObjectByIdMap) {}
    
    public virtual void onAfterUndelete(Map<Id, SObject> newSObjectByIdMap) {}
}