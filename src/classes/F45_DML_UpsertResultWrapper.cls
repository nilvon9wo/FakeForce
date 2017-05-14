public with sharing class F45_DML_UpsertResultWrapper implements F45_DML_GenericResultWrapperIntf {
	@testVisible private Id id;
	@testVisible private Boolean wasSuccess;
	@testVisible private Boolean wasCreated;
	@testVisible private List<F45_DML_DatabaseErrorWrapper> errorList; 
	
    public F45_DML_UpsertResultWrapper(Database.UpsertResult result) {
    	this.id = result.id;
    	this.wasCreated = result.isCreated();
    	this.wasSuccess = result.isSuccess();
    	this.errorList = (new F45_DML_DatabaseErrorHelper()).convert(result.errors);
    } 
    
    @testVisible() 
    private F45_DML_UpsertResultWrapper() {
    } 
    
    public Id getId() {
    	return this.id;
	}
	    
    public Boolean isCreated() {
    	return this.wasCreated;
	}
	
    public Boolean isSuccess() {
    	return this.wasSuccess;
	}

	public List<F45_DML_DatabaseErrorWrapper> getErrorList() {
		return this.errorList;
	}
}