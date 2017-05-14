public with sharing class F45_DML_DeleteResultListWrapper implements F45_DML_GenericResultListWrapperIntf {
    @testVisible private List<F45_DML_DeleteResultWrapper> resultWrapperList;
    
    public F45_DML_DeleteResultListWrapper(List<Database.DeleteResult> DeleteResultList) {
    	this.resultWrapperList = new List<F45_DML_DeleteResultWrapper>();
    	for (Database.DeleteResult DeleteResult : DeleteResultList) {
    		resultWrapperList.add(new F45_DML_DeleteResultWrapper(DeleteResult));
    	} 
    }
    
    public List<F45_DML_DeleteResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}