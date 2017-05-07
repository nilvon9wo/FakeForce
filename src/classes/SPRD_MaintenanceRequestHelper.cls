public class SPRD_MaintenanceRequestHelper {
    List<Case> maintenanceRequestList;
    SPRD_MaintenanceRequests maintenanceRequests; 
    
    public SPRD_MaintenanceRequestHelper(List<Case> maintenanceRequestList, SPRD_MaintenanceRequests maintenanceRequests) {
        this.maintenanceRequestList = maintenanceRequestList;
        this.maintenanceRequests = maintenanceRequests;
    }
 
    public SPRD_MaintenanceRequestHelper(List<Case> maintenanceRequestList) {
        this(maintenanceRequestList, new SPRD_MaintenanceRequests(maintenanceRequestList));
    }
    
    // ---------------------------------------

	public static void updateWorkOrders(List<Case> newMaintenanceRequestList, Map<Id,Case> existingMaintenanceRequestMap) {
		SPRD_MaintenanceRequestHelper helper = (new SPRD_MaintenanceRequestHelper(newMaintenanceRequestList));
		helper.onAfterUpdate(existingMaintenanceRequestMap);
	}
	
    public void onAfterUpdate(Map<Id,SObject> existingMaintenanceRequestMap) {
    	maintenanceRequests.updateWorkOrders(existingMaintenanceRequestMap);
    }
}