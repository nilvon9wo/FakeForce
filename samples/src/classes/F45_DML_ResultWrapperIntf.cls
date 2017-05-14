public interface F45_DML_ResultWrapperIntf {
	Id getId();
	Boolean isSuccess();
	List<F45_DML_DatabaseErrorWrapper> getErrorList();
}