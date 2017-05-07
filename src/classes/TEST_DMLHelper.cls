@isTest
public class TEST_DMLHelper {
	public static List<SObject> doInsert (List<SObject> sObjectList, TEST_DummyInsertModeEnum insertMode) {
		if (insertMode == TEST_DummyInsertModeEnum.REAL){
			insert sObjectList;
		}
		else if (insertMode == TEST_DummyInsertModeEnum.MOCK) {
			TEST_MockDMLHelper.mockInsert(sObjectList);
		}
		return sObjectList;
	}
}