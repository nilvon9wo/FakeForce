public with sharing class F45_DML_DatabaseErrorHelper {
    public List<F45_DML_DatabaseErrorWrapper> convert(List<Database.Error> errorList) {
    	if (errorList == null) {
    		return null;
    	}
    	
    	List<F45_DML_DatabaseErrorWrapper> wrapperList = new List<F45_DML_DatabaseErrorWrapper>();
    	for (Database.Error error : errorList) {
    		wrapperList.add(new F45_DML_DatabaseErrorWrapper(error));
    	}
		return wrapperList;	    	 
    }
}