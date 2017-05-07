@isTest
public class F45_DMLHelper {
	public static List<SObject> doInsert (List<SObject> sObjectList, F45_DummyInsertMode insertMode) {
		if (insertMode == F45_DummyInsertMode.REAL){
			insert sObjectList;
		}
		else if (insertMode == F45_DummyInsertMode.MOCK) {
			F45_MockDMLHelper.mockInsert(sObjectList);
		}
		return sObjectList;
	}
}