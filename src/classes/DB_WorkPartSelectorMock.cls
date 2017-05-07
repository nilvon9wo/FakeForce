@isTest 
public class DB_WorkPartSelectorMock extends DB_WorkPartSelector{  
	Decimal daysTilNextServiceDue;
	
	public DB_WorkPartSelectorMock(Decimal daysTilNextServiceDue){
		this.daysTilNextServiceDue = daysTilNextServiceDue;
	}
	
    public override List<Work_Part__c> selectByMaintenanceRequestIdWithEquipment(Set<Id> idSet) {
    	Product2 equipmentTemplate = new Product2(maintenance_cycle__c = this.daysTilNextServiceDue);  
		Product2 equipment = TEST_EquipmentFactory.create(equipmentTemplate, TEST_DummyInsertModeEnum.MOCK);
		Work_Part__c workPartTemplate = new Work_Part__c(
			maintenance_request__c = new List<Id>(idSet)[0],
			equipment__c = equipment.id,
			equipment__r = equipment
		); 		
		return new List<Work_Part__c>{ TEST_WorkPartFactory.create(workPartTemplate, TEST_DummyInsertModeEnum.MOCK)};  
    }  
	
}