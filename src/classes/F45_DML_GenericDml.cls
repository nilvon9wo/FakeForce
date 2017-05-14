public virtual class F45_DML_GenericDml {
	public static Boolean IS_ALL_OR_NONE = true; 
	public static Boolean NOT_ALL_OR_NONE = false; 
	
    public virtual F45_DML_SaveResultListWrapper doInsert(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_DML_SaveResultListWrapper(Database.insert(objectList, isAllOrNone));
    }
    
    public virtual F45_DML_SaveResultListWrapper doInsert(List<SObject> objectList) {
    	return this.doInsert(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_DML_SaveResultListWrapper doUpdate(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_DML_SaveResultListWrapper(Database.update(objectList, isAllOrNone));
    }
    
    public virtual F45_DML_SaveResultListWrapper doUpdate(List<SObject> objectList) {
    	return this.doUpdate(objectList, IS_ALL_OR_NONE);
    }

    public virtual F45_DML_UpsertResultListWrapper doUpsert(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_DML_UpsertResultListWrapper(Database.upsert(objectList, isAllOrNone));
    }
    
    public virtual F45_DML_UpsertResultListWrapper doUpsert(List<SObject> objectList) {
    	return this.doUpsert(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_DML_DeleteResultListWrapper doDelete(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_DML_DeleteResultListWrapper(Database.delete(objectList, isAllOrNone));
    }
    
    public virtual F45_DML_DeleteResultListWrapper doDelete(List<SObject> objectList) {
    	return this.doDelete(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual F45_DML_UndeleteResultListWrapper doUndelete(List<SObject> objectList, Boolean isAllOrNone) {
    	return new F45_DML_UndeleteResultListWrapper(Database.undelete(objectList, isAllOrNone));
    }
    
    public virtual F45_DML_UndeleteResultListWrapper doUndelete(List<SObject> objectList) {
    	return this.doUndelete(objectList, IS_ALL_OR_NONE);
    }
}