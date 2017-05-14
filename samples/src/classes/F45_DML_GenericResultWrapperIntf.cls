public interface F45_DML_GenericResultWrapperIntf {
	Id getId();
	Boolean isSuccess();
	List<F45_DML_DatabaseErrorWrapper> getErrorList();
}