public virtual class SDAO_WorkPartSelector  {
    public virtual List<Work_Part__c> selectByMaintenanceRequestIdWithEquipment(Set<Id> idSet) {
    	return [
    		SELECT id, equipment__c, equipment__r.maintenance_cycle__c, maintenance_request__c
    		FROM Work_Part__c
    		WHERE maintenance_request__c IN :idSet
    	];
    }  
}