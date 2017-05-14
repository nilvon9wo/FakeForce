public interface F45_DmlResultWrapperInterface {
	Id getId();
	Boolean isSuccess();
	List<F45_DatabaseErrorWrapper> getErrorList();
}