@isTest 
public class HWR_MaintenanceRequestsMock extends HWR_MaintenanceRequests {
	public Boolean workOrdersWereUpdated {get; private set;}

    public HWR_MaintenanceRequestsMock(List<Case> maintenanceRequestList) {
    	super(maintenanceRequestList, new DB_GenericDmlMock(), new DB_WorkPartSelectorMock(0));
    }
	
	public override void updateWorkOrders(Map<Id,SObject> oldMaintenanceRequestMap) {
		this.workOrdersWereUpdated = true;
	}
}