public with sharing class F45_DML_UpsertResultListWrapper implements F45_DML_GenericResultListWrapperIntf {
    @testVisible private List<F45_DML_UpsertResultWrapper> resultWrapperList;
    
    public F45_DML_UpsertResultListWrapper(List<Database.UpsertResult> UpsertResultList) {
    	this.resultWrapperList = new List<F45_DML_UpsertResultWrapper>();
    	for (Database.UpsertResult UpsertResult : UpsertResultList) {
    		resultWrapperList.add(new F45_DML_UpsertResultWrapper(UpsertResult));
    	} 
    }
    
    public List<F45_DML_UpsertResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}