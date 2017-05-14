public with sharing class F45_DML_UndeleteResultListWrapper implements F45_DML_ResultListWrapperIntf {
    @testVisible private List<F45_DML_UndeleteResultWrapper> resultWrapperList;
    
    public F45_DML_UndeleteResultListWrapper(List<Database.UndeleteResult> UndeleteResultList) {
    	this.resultWrapperList = new List<F45_DML_UndeleteResultWrapper>();
    	for (Database.UndeleteResult UndeleteResult : UndeleteResultList) {
    		resultWrapperList.add(new F45_DML_UndeleteResultWrapper(UndeleteResult));
    	} 
    }
    
    public List<F45_DML_UndeleteResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}