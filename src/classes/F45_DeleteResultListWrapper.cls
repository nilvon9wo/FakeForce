public with sharing class F45_DeleteResultListWrapper implements F45_DmlResultListWrapperInterface {
    @testVisible private List<F45_DeleteResultWrapper> resultWrapperList;
    
    public F45_DeleteResultListWrapper(List<Database.DeleteResult> DeleteResultList) {
    	this.resultWrapperList = new List<F45_DeleteResultWrapper>();
    	for (Database.DeleteResult DeleteResult : DeleteResultList) {
    		resultWrapperList.add(new F45_DeleteResultWrapper(DeleteResult));
    	} 
    }
    
    public List<F45_DeleteResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}