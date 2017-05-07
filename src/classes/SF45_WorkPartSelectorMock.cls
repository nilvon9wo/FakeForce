@isTest 
public class SF45_WorkPartSelectorMock extends SDAO_WorkPartSelector{  
	Decimal daysTilNextServiceDue;
	
	public SF45_WorkPartSelectorMock(Decimal daysTilNextServiceDue){
		this.daysTilNextServiceDue = daysTilNextServiceDue;
	}
	
    public override List<Work_Part__c> selectByMaintenanceRequestIdWithEquipment(Set<Id> idSet) {
    	Product2 productTemplate = new Product2(maintenance_cycle__c = this.daysTilNextServiceDue);  
		Product2 product = SF45_ProductFactory.create(productTemplate, F45_DummyInsertMode.MOCK);
		Work_Part__c workPartTemplate = new Work_Part__c(
			maintenance_request__c = new List<Id>(idSet)[0],
			equipment__c = product.id,
			equipment__r = product
		); 		
		return new List<Work_Part__c>{ SF45_WorkPartFactory.create(workPartTemplate, F45_DummyInsertMode.MOCK)};  
    }  
	
}