public interface F45_TRIG_TriggerHandlerIntf {
    void onBeforeInsert(List<SObject> newSObjectList);
    void onAfterInsert (Map<Id, SObject> newSObjectByIdMap);

    void onBeforeUpdate(Map<Id, SObject> newSObjectByIdMap, Map<Id, SObject> oldSObjectByIdMap);
    void onAfterUpdate (Map<Id, SObject> newSObjectByIdMap, Map<Id, SObject> oldSObjectByIdMap);

    void onBeforeDelete(Map<Id, SObject> oldSObjectByIdMap);
    void onAfterDelete (Map<Id, SObject> oldSObjectByIdMap);
    
    void onAfterUndelete(Map<Id, SObject> newSObjectByIdMap);
} 