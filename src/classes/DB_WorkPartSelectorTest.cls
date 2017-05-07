@isTest
private class DB_WorkPartSelectorTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void testSelectByMaintenanceRequestIdWithEquipmentShouldIncludeEquipment(){
		// Arrange
		DB_WorkPartSelector targetClass = new DB_WorkPartSelector();

		Product2 equipmentTemplate = new Product2(maintenance_cycle__c = 5322);
		Id testEquipmentId = TEST_EquipmentFactory.create(equipmentTemplate, TEST_DummyInsertModeEnum.REAL).id;
		Id testMaintenanceRequestId = TEST_MaintenanceRequestFactory.create(TEST_DummyInsertModeEnum.REAL).id;  
		Work_Part__c workPartTemplate = new Work_Part__c(equipment__c = testEquipmentId, maintenance_request__c = testMaintenanceRequestId); 
		TEST_WorkPartFactory.create(workPartTemplate, TEST_DummyInsertModeEnum.REAL);
		
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
		System.assertEquals(1, resultList.size());
		
		Work_Part__c resultMaintenanceRequest = resultList[0];
		System.assertEquals(testMaintenanceRequestId, resultMaintenanceRequest.maintenance_request__c);
		System.assertEquals(testEquipmentId, resultMaintenanceRequest.equipment__c);
		System.assertEquals(equipmentTemplate.maintenance_cycle__c, resultMaintenanceRequest.equipment__r.maintenance_cycle__c);
	}
}