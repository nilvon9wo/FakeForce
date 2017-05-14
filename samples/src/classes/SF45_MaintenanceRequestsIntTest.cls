@isTest
private class SF45_MaintenanceRequestsIntTest {
	private static final User TestRunner = F45_FTY_RunAsUserFactory.create(); 
	private static final Integer DAYS_TIL_NEXT_SERVICE_DUE = 35;
	
	@isTest static void testUpdateWorkOrdersShouldCreateNewRequestsForClosedRoutineMaintenance(){
		// Arrange
		SPRD_MaintenanceRequests targetClass = initializeMaintenanceRequests('Routine Maintenance');

		Case oldMaintenanceRequest = targetClass.maintenanceRequestList[0].clone(true, true, true, true);
		Map<Id,SObject> oldMaintenanceRequestMap = new Map<Id,SObject>{ oldMaintenanceRequest.id => oldMaintenanceRequest };
		
		// Act  
        System.runAs(TestRunner){
            Test.startTest();
            {
                targetClass.updateWorkOrders(oldMaintenanceRequestMap);
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
	
	private static SPRD_MaintenanceRequests initializeMaintenanceRequests(
			String requestType 
		) {
		Case maintenanceRequestTemplate = new Case(
			status = 'Closed', 
			vehicle__c = SF45_VehicleFactory.create(F45_FTY_RecordInsertMode.REAL).id, 
			equipment__c = SF45_ProductFactory.create(F45_FTY_RecordInsertMode.REAL).id, 
			type = requestType
		);
		Case newMaintenanceRequest = SF45_CaseFactory.create(maintenanceRequestTemplate, F45_FTY_RecordInsertMode.REAL);
		Case closedMaintenanceRequest = [
			SELECT id, isClosed, vehicle__c, equipment__c, type
			FROM Case
			WHERE id = :newMaintenanceRequest.id
		];		
		List<Case> closedMaintenanceRequestList = new List<Case>{closedMaintenanceRequest};
		
		initializeSelector(closedMaintenanceRequest.id);
		return new SPRD_MaintenanceRequests(closedMaintenanceRequestList);
	}
	
	private static void initializeSelector(Id maintenanceRequestId) {
    	Product2 equipmentTemplate = new Product2(maintenance_cycle__c = DAYS_TIL_NEXT_SERVICE_DUE);  
		Product2 equipment = SF45_ProductFactory.create(equipmentTemplate, F45_FTY_RecordInsertMode.REAL);
		Work_Part__c workPartTemplate = new Work_Part__c(
			maintenance_request__c = maintenanceRequestId,
			equipment__c = equipment.id,
			equipment__r = equipment
		); 		
		SF45_WorkPartFactory.create(workPartTemplate, F45_FTY_RecordInsertMode.REAL);  
	}
	
	
}