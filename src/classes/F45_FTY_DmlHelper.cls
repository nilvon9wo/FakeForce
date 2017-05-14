@isTest
public class F45_FTY_DmlHelper {
	public static List<SObject> doInsert (List<SObject> sObjectList, F45_FTY_DummyInsertMode insertMode) {
		if (insertMode == F45_FTY_DummyInsertMode.REAL){
			insert sObjectList;
		}
		else if (insertMode == F45_FTY_DummyInsertMode.MOCK) {
			F45_FTY_MockDmlHelper.mockInsert(sObjectList);
		}
		return sObjectList;
	}
}