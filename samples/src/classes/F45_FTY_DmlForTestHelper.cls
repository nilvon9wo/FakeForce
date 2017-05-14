@isTest
public class F45_FTY_DmlForTestHelper implements F45_FTY_DmlHelperIntf {
    private static Integer mockIdCounter = 1;

	public List<SObject> doInsert (List<SObject> sObjectList, F45_FTY_RecordInsertMode insertMode) {
		if (insertMode == F45_FTY_RecordInsertMode.REAL){
			insert sObjectList;
		}
		else if (insertMode == F45_FTY_RecordInsertMode.MOCK) {
			this.mockInsert(sObjectList);
		}
		return sObjectList;
	}

    public void mockInsert (List<SObject> dummySObjectList) {   
        for (SObject dummySObject : dummySObjectList) {                           
            String  mockIdString   = '00000000000' + mockIdCounter++;   // We increment the mockIdCounter so each dummy SObject gets a unique identifier.
            Integer subStringStart = (mockIdString.length() > 12) ? (mockIdString.length() - 12) : 0; 
            dummySObject.put('id', (Id) (F45_FTY_SObjectPrefixHelper.get(dummySObject.getSObjectType()) + mockIdString.subString(subStringStart))); 
        }  
    } 
}