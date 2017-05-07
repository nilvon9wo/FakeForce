public virtual class DB_WorkPartSelector extends fflib_SObjectSelector {

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
        fflib_QueryFactory queryFactory = newQueryFactory();
        new DB_EquipmentSelector().configureQueryFactoryFields(queryFactory, 'equipment__c');
        return (List<Work_Part__c>) Database.query(
                queryFactory.setCondition('maintenance_request__c IN :idSet').toSOQL()
        );
    }  
}