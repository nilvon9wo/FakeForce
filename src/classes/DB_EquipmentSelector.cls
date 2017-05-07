public class DB_EquipmentSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Product2.id,
                Product2.maintenance_cycle__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }
    
    public List<Product2> selectById(Set<Id> idSet) {
        return (List<Product2>) selectSObjectsById(idSet);
    }
}