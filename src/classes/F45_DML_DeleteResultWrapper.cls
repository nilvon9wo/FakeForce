public with sharing class F45_DML_DeleteResultWrapper implements F45_DML_GenericResultWrapperIntf {
	@testVisible private Id id;
	@testVisible private Boolean wasSuccess;
	@testVisible private List<F45_DML_DatabaseErrorWrapper> errorList; 
	
    public F45_DML_DeleteResultWrapper(Database.DeleteResult result) {
    	this.id = result.id;
    	this.wasSuccess = result.isSuccess();
    	for (Database.Error error : result.errors) {
    		if (errorList == null) {
    			errorList = new List<F45_DML_DatabaseErrorWrapper>();
    		}
    		errorList.add(new F45_DML_DatabaseErrorWrapper(error));
    	}
    } 
    
    @testVisible() 
    private F45_DML_DeleteResultWrapper() {
    } 
    
    public Id getId() {
    	return this.id;
	}
	    
    public Boolean isSuccess() {
    	return this.wasSuccess;
	}
	
	public List<F45_DML_DatabaseErrorWrapper> getErrorList() {
		return this.errorList;
	}
}