public with sharing class F45_SaveResultListWrapper implements F45_DmlResultListWrapperInterface {
    @testVisible private List<F45_SaveResultWrapper> resultWrapperList;
    
    public F45_SaveResultListWrapper(List<Database.SaveResult> saveResultList) {
    	this.resultWrapperList = new List<F45_SaveResultWrapper>();
    	for (Database.SaveResult saveResult : saveResultList) {
    		resultWrapperList.add(new F45_SaveResultWrapper(saveResult));
    	} 
    }
    
    public List<F45_SaveResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}