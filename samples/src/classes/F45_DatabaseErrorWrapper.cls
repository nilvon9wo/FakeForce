public with sharing class F45_DatabaseErrorWrapper {
	@testVisible public List<String> fieldList {get; private set;}
	@testVisible public String message {get; private set;}
	@testVisible public StatusCode statusCode {get; private set;}
	
    public F45_DatabaseErrorWrapper(Database.Error error) {
    	this.fieldList = error.getFields();
    	this.message = error.getMessage();
    	this.statusCode = error.getStatusCode();
    }
    
    @testVisible private F45_DatabaseErrorWrapper() {
    } 
}