public virtual class SPRD_MaintenanceRequests {  
    @testVisible private List<Case> maintenanceRequestList;
    private F45_GenericDml genericDml; 
    private SDAO_WorkPartSelector workPartSelector;
 
    public SPRD_MaintenanceRequests(
    		List<Case> maintenanceRequestList, 
    		F45_GenericDml genericDml, 
    		SDAO_WorkPartSelector workPartSelector
    	) {
        this.maintenanceRequestList = maintenanceRequestList;
        this.genericDml = genericDml;
        this.workPartSelector = workPartSelector; 
    } 

    public SPRD_MaintenanceRequests(List<Case> maintenanceRequestList) {
        this(maintenanceRequestList, new F45_GenericDml(), new SDAO_WorkPartSelector());
    } 

    public virtual void updateWorkOrders(Map<Id,SObject> oldMaintenanceRequestMap) {
    	List<Work_Part__c> workPartList = workPartSelector.selectByMaintenanceRequestIdWithEquipment(oldMaintenanceRequestMap.keySet());
    	
    	List<Case> newMaintenanceRequestList = new List<Case>();
    	for (Case maintenanceRequest : maintenanceRequestList) { 
    		if (this.isClosed(maintenanceRequest) && this.isUpdateRequired(oldMaintenanceRequestMap, maintenanceRequest)) {
	    		newMaintenanceRequestList.add(new Case(
	    			vehicle__c = maintenanceRequest.vehicle__c,
	    			equipment__c = maintenanceRequest.equipment__c,
	    			type = 'Routine Maintenance', 
	    			subject = 'Routine Maintenance for Vehicle ' + maintenanceRequest.vehicle__c,
	    			date_reported__c = Date.today(),
	    			date_due__c = this.selectDueDate(maintenanceRequest, workPartList)
	    		));
    		} 
    	}  
    	genericDml.doInsert(newMaintenanceRequestList);
    }
    
    // Required for testability
    private Boolean isClosed(Case maintenanceRequest){
    	return maintenanceRequest.isClosed || maintenanceRequest.status == 'Closed'; 
    }
    
    private Boolean isUpdateRequired(Map<Id,SObject> oldMaintenanceRequestMap, Case newCase) {
    	Case oldCase = (Case) oldMaintenanceRequestMap.get(newCase.id);
    	Set<String> typeNeedsUpdateSet = new Set<String>{'Repair', 'Routine Maintenance'};
    	return typeNeedsUpdateSet.contains(oldCase.type);
    }
    
    @testVisible
    private Date selectDueDate(Case maintenanceRequest, List<Work_Part__c> workPartList) {
    	Decimal daysTilMaintenance = 2147483647;
    	if (workPartList != null) {
	    	for (Work_Part__c workPart : workPartList) {
	    		if (
	    			workPart.maintenance_request__c == maintenanceRequest.id
	    			&& workPart.equipment__c != null
	    			&& workPart.equipment__r.maintenance_cycle__c != null
	    			&& daysTilMaintenance > workPart.equipment__r.maintenance_cycle__c
	    		) {
	    			daysTilMaintenance = workPart.equipment__r.maintenance_cycle__c; 
	    		}
	    	}
    	}
    	
    	Date returnDate = Date.today().addDays((Integer) daysTilMaintenance);
    	return (returnDate.year() <= 4000)
    		? returnDate
    		: Date.today().addYears(4000 - Date.today().year());
    }
}