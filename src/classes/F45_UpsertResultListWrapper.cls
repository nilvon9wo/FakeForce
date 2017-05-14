public with sharing class F45_UpsertResultListWrapper implements F45_DmlResultListWrapperInterface {
    @testVisible private List<F45_UpsertResultWrapper> resultWrapperList;
    
    public F45_UpsertResultListWrapper(List<Database.UpsertResult> UpsertResultList) {
    	this.resultWrapperList = new List<F45_UpsertResultWrapper>();
    	for (Database.UpsertResult UpsertResult : UpsertResultList) {
    		resultWrapperList.add(new F45_UpsertResultWrapper(UpsertResult));
    	} 
    }
    
    public List<F45_UpsertResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}