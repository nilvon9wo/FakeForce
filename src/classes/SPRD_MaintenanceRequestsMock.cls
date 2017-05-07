@isTest 
public class SPRD_MaintenanceRequestsMock extends SPRD_MaintenanceRequests {
	public Boolean workOrdersWereUpdated {get; private set;}

    public SPRD_MaintenanceRequestsMock(List<Case> maintenanceRequestList) {
    	super(maintenanceRequestList, new SDAO_GenericDmlMock(), new SDAO_WorkPartSelectorMock(0));
    }
	
	public override void updateWorkOrders(Map<Id,SObject> oldMaintenanceRequestMap) {
		this.workOrdersWereUpdated = true;
	}
}