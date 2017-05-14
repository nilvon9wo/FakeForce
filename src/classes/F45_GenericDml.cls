/**
 * This is NOT a test class.
 * Inject this class into the classes where you perform DML so you can mock it out with F45_GenericDmlMock during testing.
 **/ 
public virtual class F45_GenericDml {
	public static Boolean IS_ALL_OR_NONE = true; 
	public static Boolean NOT_ALL_OR_NONE = false; 
	
    public virtual F45_SaveResultListWrapper doInsert(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_SaveResultListWrapper(Database.insert(objectList, isAllOrNone));
    }
    
    public virtual F45_SaveResultListWrapper doInsert(List<SObject> objectList) {
    	return this.doInsert(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_SaveResultListWrapper doUpdate(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_SaveResultListWrapper(Database.update(objectList, isAllOrNone));
    }
    
    public virtual F45_SaveResultListWrapper doUpdate(List<SObject> objectList) {
    	return this.doUpdate(objectList, IS_ALL_OR_NONE);
    }

    public virtual F45_UpsertResultListWrapper doUpsert(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_UpsertResultListWrapper(Database.upsert(objectList, isAllOrNone));
    }
    
    public virtual F45_UpsertResultListWrapper doUpsert(List<SObject> objectList) {
    	return this.doUpsert(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_DeleteResultListWrapper doDelete(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_DeleteResultListWrapper(Database.delete(objectList, isAllOrNone));
    }
    
    public virtual F45_DeleteResultListWrapper doDelete(List<SObject> objectList) {
    	return this.doDelete(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_UndeleteResultListWrapper doUndelete(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_UndeleteResultListWrapper(Database.undelete(objectList, isAllOrNone));
    }
    
    public virtual F45_UndeleteResultListWrapper doUndelete(List<SObject> objectList) {
    	return this.doUndelete(objectList, IS_ALL_OR_NONE);
    }
}