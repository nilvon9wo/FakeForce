public with sharing class F45_DML_SaveResultListWrapper implements F45_DML_ResultListWrapperIntf {
    @testVisible private List<F45_DML_SaveResultWrapper> resultWrapperList;
    
    public F45_DML_SaveResultListWrapper(List<Database.SaveResult> saveResultList) {
    	this.resultWrapperList = new List<F45_DML_SaveResultWrapper>();
    	for (Database.SaveResult saveResult : saveResultList) {
    		resultWrapperList.add(new F45_DML_SaveResultWrapper(saveResult));
    	} 
    }

    @testVisible
    private F45_DML_SaveResultListWrapper() {
    }
    
    public List<F45_DML_SaveResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}