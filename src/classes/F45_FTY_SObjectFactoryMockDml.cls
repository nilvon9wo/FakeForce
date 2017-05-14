@isTest 
public class F45_FTY_SObjectFactoryMockDml extends F45_FTY_SObjectFactoryDml {
    private static Integer mockIdCounter = 1;

	public override F45_DML_SaveResultListWrapper doInsert (List<SObject> sObjectList, F45_FTY_RecordInsertMode insertMode) {
		if (insertMode == F45_FTY_RecordInsertMode.MOCK) {
			this.mockInsert(sObjectList);
			return mockWrapResults(sObjectList);
		} 
		
		return super.doInsert(sObjectList, insertMode); 
	}

    private void mockInsert (List<SObject> dummySObjectList) {   
        for (SObject dummySObject : dummySObjectList) {                           
            String  mockIdString   = '00000000000' + mockIdCounter++;   // We increment the mockIdCounter so each dummy SObject gets a unique identifier.
            Integer subStringStart = (mockIdString.length() > 12) ? (mockIdString.length() - 12) : 0; 
            dummySObject.put('id', (Id) (F45_FTY_SObjectPrefixHelper.get(dummySObject.getSObjectType()) + mockIdString.subString(subStringStart))); 
        }  
    }
    
    private F45_DML_SaveResultListWrapper mockWrapResults(List<SObject> sObjectList) {
    	List<F45_DML_SaveResultWrapper> saveResultWrapperList = new List<F45_DML_SaveResultWrapper>();
    	for (SObject sObj : sObjectList) {
    		saveResultWrapperList.add(mockWrapResult(sObj));
    	} 
    	
    	F45_DML_SaveResultListWrapper saveResultListWrapper = new F45_DML_SaveResultListWrapper();
    	saveResultListWrapper.resultWrapperList = saveResultWrapperList;
    	return saveResultListWrapper;
    }
    
    private F45_DML_SaveResultWrapper mockWrapResult(SObject sObj) {
    	F45_DML_SaveResultWrapper saveResultWrapper = new F45_DML_SaveResultWrapper();
    		saveResultWrapper.id = sObj.id;
    		saveResultWrapper.wasSuccess = true;
    		saveResultWrapper.errorList = new List<F45_DML_DatabaseErrorWrapper>();
    	return saveResultWrapper;
    }
}