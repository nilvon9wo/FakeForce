public with sharing class F45_DML_DatabaseErrorHelper {
    public List<F45_DML_DatabaseErrorWrapper> convert(List<Database.Error> errorList) {
    	List<F45_DML_DatabaseErrorWrapper> wrapperList = new List<F45_DML_DatabaseErrorWrapper>();
    	if (errorList != null) {
	    	for (Database.Error error : errorList) {
	    		wrapperList.add(new F45_DML_DatabaseErrorWrapper(error));
	    	}
    	}
		return wrapperList;	    	 
    }
}