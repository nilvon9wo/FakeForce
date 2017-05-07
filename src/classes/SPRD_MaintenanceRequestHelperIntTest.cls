@isTest
private class MaintenanceRequestHelperIntTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final Integer DAYS_TIL_NEXT_SERVICE_DUE = 35;
	
	@isTest static void testUpdateWorkOrdersShouldCreateNewRequestsForClosedRoutineMaintenance(){
		// Arrange
		Case oldMaintenanceRequest = TEST_MaintenanceRequestFactory.createRealClosingMaintenanceRequest('Routine Maintenance');
		MaintenanceRequestHelper targetClass = initializeMaintenanceRequests(oldMaintenanceRequest);

		Map<Id,SObject> oldMaintenanceRequestMap = new Map<Id,SObject>{ oldMaintenanceRequest.id => oldMaintenanceRequest };
		
		// Act  
        System.runAs(TestRunner){
            Test.startTest();
            {
                targetClass.onAfterUpdate(oldMaintenanceRequestMap);
            }
            Test.stopTest();
        } 

		// Assert
		List<SObject> insertedSObjectList = [
			SELECT vehicle__c, equipment__c, type, subject, date_reported__c, date_due__c
			FROM Case
			WHERE id != :oldMaintenanceRequest.id AND vehicle__c = :oldMaintenanceRequest.vehicle__c
		];
		System.assertEquals(1, insertedSObjectList.size());
		Case insertedCase = (Case)insertedSObjectList[0];
		System.assertEquals(oldMaintenanceRequest.vehicle__c, insertedCase.vehicle__c);
		System.assertEquals(oldMaintenanceRequest.equipment__c, insertedCase.equipment__c);
		System.assertEquals('Routine Maintenance', insertedCase.type);
		System.assertEquals('Routine Maintenance for Vehicle ' + oldMaintenanceRequest.vehicle__c, insertedCase.subject);
		System.assertEquals(Date.today(), insertedCase.date_reported__c);
		System.assertEquals(Date.today().addDays((Integer) DAYS_TIL_NEXT_SERVICE_DUE), insertedCase.date_due__c);
	}
	
	private static MaintenanceRequestHelper initializeMaintenanceRequests(Case closingMaintenanceRequest) {
		List<Case> closingMaintenanceRequestList = new List<Case>{closingMaintenanceRequest};
		populateWorkPartSelector(closingMaintenanceRequest.id);
		return new MaintenanceRequestHelper(closingMaintenanceRequestList);
	}
	
	private static void populateWorkPartSelector(Id maintenanceRequestId) {
    	Product2 equipmentTemplate = new Product2(maintenance_cycle__c = DAYS_TIL_NEXT_SERVICE_DUE);  
		Product2 equipment = TEST_EquipmentFactory.create(equipmentTemplate, TEST_DummyInsertModeEnum.REAL);
		Work_Part__c workPartTemplate = new Work_Part__c(
			maintenance_request__c = maintenanceRequestId,
			equipment__c = equipment.id,
			equipment__r = equipment
		); 		
		TEST_WorkPartFactory.create(workPartTemplate, TEST_DummyInsertModeEnum.REAL);  
	}
}