/**
 * We can't mock out the return types for these methods, so we return empty lists.
 * If your code will do something with the returns, you must put your result process into an injectable dependency 
 * so you can replace the handler while your tests are executing.
 **/
@isTest 
public class F45_GenericDmlMock extends F45_GenericDml {
	// These need to be lists in case there are multiple DML operations during your test.
	// Otherwise, only the last operation would be verifiable.
	public List<List<SObject>> insertedSObjectListList = new List<List<SObject>>();
	public List<Boolean> insertWasAllOrNoneList = new List<Boolean>();

	public List<List<SObject>> updatedSObjectListList = new List<List<SObject>>();
	public List<Boolean> updateWasAllOrNoneList = new List<Boolean>();

	public List<List<SObject>> upsertedSObjectListList = new List<List<SObject>>();
	public List<Boolean> upsertWasAllOrNoneList = new List<Boolean>();

	public List<List<SObject>> deletedSObjectListList = new List<List<SObject>>();
	public List<Boolean> deleteWasAllOrNoneList = new List<Boolean>();

	public List<List<SObject>> undeletedSObjectListList = new List<List<SObject>>();
	public List<Boolean> undeleteWasAllOrNoneList = new List<Boolean>();
	
    public override List<Database.SaveResult> doInsert(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.insertedSObjectListList.add(objectList);
    	}
   		this.insertWasAllOrNoneList.add(isAllOrNone);
   		
   		// Unfortunately, I can't find information how to construct a SaveResult, so we can't mock the return. :-(
   		return new List<Database.SaveResult>();
    }

    public override List<Database.SaveResult> doUpdate(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.updatedSObjectListList.add(objectList);
    	}
   		this.updateWasAllOrNoneList.add(isAllOrNone);
   		
   		// Unfortunately, I can't find information how to construct a SaveResult, so we can't mock the return. :-(
   		return new List<Database.SaveResult>();
    }
    
    public override List<Database.UpsertResult> doUpsert(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.upsertedSObjectListList.add(objectList);
    	}
   		this.upsertWasAllOrNoneList.add(isAllOrNone);
   		
   		// Unfortunately, I can't find information how to construct a UpsertResult, so we can't mock the return. :-(
   		return new List<Database.UpsertResult>();
    }
    
    public override List<Database.DeleteResult> doDelete(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.deletedSObjectListList.add(objectList);
    	}
   		this.deleteWasAllOrNoneList.add(isAllOrNone);
   		
   		// Unfortunately, I can't find information how to construct a DeleteResult, so we can't mock the return. :-(
   		return new List<Database.DeleteResult>();
    }
    
    public override List<Database.UndeleteResult> doUndelete(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.undeletedSObjectListList.add(objectList);
    	}
   		this.undeleteWasAllOrNoneList.add(isAllOrNone);
   		
   		// Unfortunately, I can't find information how to construct a UndeleteResult, so we can't mock the return. :-(
   		return new List<Database.UndeleteResult>();
    }
}