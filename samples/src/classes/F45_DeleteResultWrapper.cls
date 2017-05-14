public with sharing class F45_DeleteResultWrapper implements F45_DmlResultWrapperInterface {
	@testVisible private Id id;
	@testVisible private Boolean wasSuccess;
	@testVisible private List<F45_DatabaseErrorWrapper> errorList; 
	
    public F45_DeleteResultWrapper(Database.DeleteResult result) {
    	this.id = result.id;
    	this.wasSuccess = result.isSuccess();
    	for (Database.Error error : result.errors) {
    		if (errorList == null) {
    			errorList = new List<F45_DatabaseErrorWrapper>();
    		}
    		errorList.add(new F45_DatabaseErrorWrapper(error));
    	}
    } 
    
    @testVisible() 
    private F45_DeleteResultWrapper() {
    } 
    
    public Id getId() {
    	return this.id;
	}
	    
    public Boolean isSuccess() {
    	return this.wasSuccess;
	}
	
	public List<F45_DatabaseErrorWrapper> getErrorList() {
		return this.errorList;
	}
}