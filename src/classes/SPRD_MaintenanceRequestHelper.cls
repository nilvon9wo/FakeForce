public class MaintenanceRequestHelper extends fflib_SObjectDomain {
    List<Case> maintenanceRequestList;
    SPRD_MaintenanceRequests maintenanceRequests; 
    
    public MaintenanceRequestHelper(List<Case> maintenanceRequestList, SPRD_MaintenanceRequests maintenanceRequests) {
        super(maintenanceRequestList);
        this.maintenanceRequestList = maintenanceRequestList;
        this.maintenanceRequests = maintenanceRequests;
    }
 
    public MaintenanceRequestHelper(List<Case> maintenanceRequestList) {
        this(maintenanceRequestList, new SPRD_MaintenanceRequests(maintenanceRequestList));
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> maintenanceRequestList) {
            return new MaintenanceRequestHelper (maintenanceRequestList);
        }
    } 
    
    // ---------------------------------------

	public static void updateWorkOrders(List<Case> newMaintenanceRequestList, Map<Id,Case> existingMaintenanceRequestMap) {
		MaintenanceRequestHelper helper = (new MaintenanceRequestHelper(newMaintenanceRequestList));
		helper.onAfterUpdate(existingMaintenanceRequestMap);
	}
	
    public override void onAfterUpdate(Map<Id,SObject> existingMaintenanceRequestMap) {
    	maintenanceRequests.updateWorkOrders(existingMaintenanceRequestMap);
    }
}