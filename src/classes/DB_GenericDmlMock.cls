@isTest 
public class DB_GenericDmlMock extends DB_GenericDml { 
	public List<SObject> insertedSObjectList {private set; get;}
	
    public override void doInsert(List<SObject> objectList) {
    	if (objectList != null && !objectList.isEmpty()) {
    		this.insertedSObjectList = objectList;
    	}
    	
    }
}