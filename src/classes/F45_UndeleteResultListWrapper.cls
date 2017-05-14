public with sharing class F45_UndeleteResultListWrapper implements F45_DmlResultListWrapperInterface {
    @testVisible private List<F45_UndeleteResultWrapper> resultWrapperList;
    
    public F45_UndeleteResultListWrapper(List<Database.UndeleteResult> UndeleteResultList) {
    	this.resultWrapperList = new List<F45_UndeleteResultWrapper>();
    	for (Database.UndeleteResult UndeleteResult : UndeleteResultList) {
    		resultWrapperList.add(new F45_UndeleteResultWrapper(UndeleteResult));
    	} 
    }
    
    public List<F45_UndeleteResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}