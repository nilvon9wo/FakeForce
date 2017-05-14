public with sharing class F45_FTY_DmlForProductionHelper implements F45_FTY_DmlHelperIntf {
	F45_DML_GenericDml genericDml;
	
	public F45_FTY_DmlForProductionHelper(F45_DML_GenericDml genericDml) {
		this.genericDml = genericDml;
	}

	public F45_FTY_DmlForProductionHelper() {
		this(new F45_DML_GenericDml());
	}

	public List<SObject> doInsert (List<SObject> sObjectList, F45_FTY_RecordInsertMode insertMode) {
		if (insertMode == F45_FTY_RecordInsertMode.MOCK){
			throw new F45_FTY_DmlForProductionHelperException('Mock insertions not allowed in production code');
		}

		genericDml.doInsert(sObjectList);
		return sObjectList;
	}
    
}