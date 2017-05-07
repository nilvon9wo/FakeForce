public virtual class SDAO_WorkPartSelector  {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Work_Part__c.id,
                Work_Part__c.equipment__c,
                Work_Part__c.maintenance_request__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Work_Part__c.sObjectType;
    }
    
    public virtual List<Work_Part__c> selectByMaintenanceRequestIdWithEquipment(Set<Id> idSet) {
    	// TODO:
    	return null;
    }  
}