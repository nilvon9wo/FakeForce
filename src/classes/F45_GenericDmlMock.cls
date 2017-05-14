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
	
	public List<F45_DmlResultListWrapperInterface> dmlResultListWrapperList;
	
    public override F45_SaveResultListWrapper doInsert(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.insertedSObjectListList.add(objectList);
    	}
   		this.insertWasAllOrNoneList.add(isAllOrNone);
   		return (F45_SaveResultListWrapper) this.getNextResultList();
    }

    public override F45_SaveResultListWrapper doUpdate(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.updatedSObjectListList.add(objectList);
    	}
   		this.updateWasAllOrNoneList.add(isAllOrNone);
   		return (F45_SaveResultListWrapper) this.getNextResultList();
    }
    
    public override F45_UpsertResultListWrapper doUpsert(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.upsertedSObjectListList.add(objectList);
    	}
   		this.upsertWasAllOrNoneList.add(isAllOrNone);
   		return (F45_UpsertResultListWrapper) this.getNextResultList();
    }
    
    public override F45_DeleteResultListWrapper doDelete(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.deletedSObjectListList.add(objectList);
    	}
   		this.deleteWasAllOrNoneList.add(isAllOrNone);
   		return (F45_DeleteResultListWrapper) this.getNextResultList();
    }
    
    public override F45_UndeleteResultListWrapper doUndelete(List<SObject> objectList, Boolean isAllOrNone) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.undeletedSObjectListList.add(objectList);
    	}
   		this.undeleteWasAllOrNoneList.add(isAllOrNone);
   		return (F45_UndeleteResultListWrapper) this.getNextResultList();
    }
    
    private Integer returnedResult = 0;
    private F45_DmlResultListWrapperInterface getNextResultList() {
    	F45_DmlResultListWrapperInterface listWrapper = dmlResultListWrapperList[returnedResult];
    	returnedResult++;
    	return listWrapper;
    }
}