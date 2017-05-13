/**
 * This is NOT a test class.
 * Inject this class into the classes where you perform DML so you can mock it out with F45_GenericDmlMock during testing.
 * 
 * Note, if your code consumes the returned results and you wish to use F45_GenericDmlMock when testing, 
 * you must also handle the consumption through another dependency.
 * We can not mock out the return types, so the mock methods return empty lists.
 **/ 
public virtual class F45_GenericDml {
	public static Boolean IS_ALL_OR_NONE = true; 
	public static Boolean NOT_ALL_OR_NONE = false; 
	
    public virtual List<Database.SaveResult> doInsert(List<SObject> objectList, Boolean isAllOrNone) {
    	return Database.insert(objectList, isAllOrNone);
    }
    
    public virtual List<Database.SaveResult> doInsert(List<SObject> objectList) {
    	return this.doInsert(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual List<Database.SaveResult> doUpdate(List<SObject> objectList, Boolean isAllOrNone) {
    	return Database.update(objectList, isAllOrNone);
    }
    
    public virtual List<Database.SaveResult> doUpdate(List<SObject> objectList) {
    	return this.doUpdate(objectList, IS_ALL_OR_NONE);
    }

    public virtual List<Database.UpsertResult> doUpsert(List<SObject> objectList, Boolean isAllOrNone) {
    	return Database.upsert(objectList, isAllOrNone);
    }
    
    public virtual List<Database.UpsertResult> doUpsert(List<SObject> objectList) {
    	return this.doUpsert(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual List<Database.DeleteResult> doDelete(List<SObject> objectList, Boolean isAllOrNone) {
    	return Database.delete(objectList, isAllOrNone);
    }
    
    public virtual List<Database.DeleteResult> doDelete(List<SObject> objectList) {
    	return this.doDelete(objectList, IS_ALL_OR_NONE);
    }
    
    public virtual List<Database.UndeleteResult> doUndelete(List<SObject> objectList, Boolean isAllOrNone) {
    	return Database.undelete(objectList, isAllOrNone);
    }
    
    public virtual List<Database.UndeleteResult> doUndelete(List<SObject> objectList) {
    	return this.doUndelete(objectList, IS_ALL_OR_NONE);
    }
}