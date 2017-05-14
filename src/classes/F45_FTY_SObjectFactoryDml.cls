public with sharing virtual class F45_FTY_SObjectFactoryDml extends F45_DML_GenericDml {
	
	public F45_FTY_SObjectFactoryDml() {
	}

	public virtual F45_DML_SaveResultListWrapper doInsert (List<SObject> sObjectList, F45_FTY_RecordInsertMode insertMode) {
		if (insertMode == F45_FTY_RecordInsertMode.MOCK){
			throw new F45_FTY_SObjectFactoryDmlException('Mock insertions not allowed in production code');
		}

		return super.doInsert(sObjectList);
	} 
}