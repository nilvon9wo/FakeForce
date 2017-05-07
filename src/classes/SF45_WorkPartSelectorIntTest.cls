@isTest
private class SF45_WorkPartSelectorIntTest {
	private static final User TestRunner = F45_RunAsUserFactory.create(); 
	
	@isTest static void testSelectByMaintenanceRequestIdWithEquipmentShouldIncludeEquipment(){
		// Arrange
		SDAO_WorkPartSelector targetClass = new SDAO_WorkPartSelector();

		Product2 equipmentTemplate = new Product2(maintenance_cycle__c = 5322);
		Id testEquipmentId = SF45_ProductFactory.create(equipmentTemplate, F45_DummyInsertMode.REAL).id;
		Id testMaintenanceRequestId = SF45_CaseFactory.create(F45_DummyInsertMode.REAL).id;  
		Work_Part__c workPartTemplate = new Work_Part__c(equipment__c = testEquipmentId, maintenance_request__c = testMaintenanceRequestId); 
		SF45_WorkPartFactory.create(workPartTemplate, F45_DummyInsertMode.REAL);
		
		Set<Id> maintenanceRequestIdSet = new Set<Id>{ testMaintenanceRequestId };
		
		// Act 
		List<Work_Part__c> resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultList = targetClass.selectByMaintenanceRequestIdWithEquipment(maintenanceRequestIdSet);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(resultList != null);
		System.assertEquals(1, resultList.size());
		
		Work_Part__c resultMaintenanceRequest = resultList[0];
		System.assertEquals(testMaintenanceRequestId, resultMaintenanceRequest.maintenance_request__c);
		System.assertEquals(testEquipmentId, resultMaintenanceRequest.equipment__c);
		System.assertEquals(equipmentTemplate.maintenance_cycle__c, resultMaintenanceRequest.equipment__r.maintenance_cycle__c);
	}
}