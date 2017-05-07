@isTest
private class HWR_MaintenanceRequestsTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final Integer DAYS_TIL_NEXT_SERVICE_DUE = 35;
	
	@isTest static void testUpdateWorkOrdersShouldCreateNewRequestsForClosedRepairs(){
		testUpdateWorkOrdersShouldCreateNewRequestsForSpecifiedClosedRequests('Repair');
	}
	
	@isTest static void testUpdateWorkOrdersShouldCreateNewRequestsForClosedRoutineMaintenance(){
		testUpdateWorkOrdersShouldCreateNewRequestsForSpecifiedClosedRequests('Routine Maintenance');
	}

	static void testUpdateWorkOrdersShouldCreateNewRequestsForSpecifiedClosedRequests(String requestType){
		// Arrange
		DB_GenericDmlMock fakeGenericDml = new DB_GenericDmlMock();  
		HWR_MaintenanceRequests targetClass = initializeMaintenanceRequests(requestType, fakeGenericDml);

		Case oldMaintenanceRequest = targetClass.maintenanceRequestList[0].clone(true, true, true, true);
		oldMaintenanceRequest.status = 'New';
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
		List<SObject> insertedSObjectList = fakeGenericDml.insertedSObjectList;
		System.assertEquals(1, insertedSObjectList.size());
		Case insertedCase = (Case)insertedSObjectList[0];
		System.assertEquals(oldMaintenanceRequest.vehicle__c, insertedCase.vehicle__c);
		System.assertEquals(oldMaintenanceRequest.equipment__c, insertedCase.equipment__c);
		System.assertEquals('Routine Maintenance', insertedCase.type);
		System.assertEquals('Routine Maintenance for Vehicle ' + oldMaintenanceRequest.vehicle__c, insertedCase.subject);
		System.assertEquals(Date.today(), insertedCase.date_reported__c);
		System.assertEquals(Date.today().addDays((Integer) DAYS_TIL_NEXT_SERVICE_DUE), insertedCase.date_due__c);
	}	
	
	@isTest static void testUpdateWorkOrdersShouldDoNothingForOpenUpdates(){
		// Arrange
		DB_GenericDmlMock fakeGenericDml = new DB_GenericDmlMock();  
		HWR_MaintenanceRequests targetClass = initializeMaintenanceRequests('Routine Maintenance', fakeGenericDml);
		targetClass.maintenanceRequestList[0].status = 'New';
		
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
		List<SObject> insertedSObjectList = fakeGenericDml.insertedSObjectList;
		System.assertEquals(null, insertedSObjectList); 
	}
	
	@isTest static void testUpdateWorkOrdersShouldDoNothingForOtherClosedRequests() {
		// Arrange
		DB_GenericDmlMock fakeGenericDml = new DB_GenericDmlMock();  
		HWR_MaintenanceRequests targetClass = initializeMaintenanceRequests('Mechanical', fakeGenericDml);
		
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
		List<SObject> insertedSObjectList = fakeGenericDml.insertedSObjectList;
		System.assertEquals(null, insertedSObjectList);
	}
	
	private static HWR_MaintenanceRequests initializeMaintenanceRequests(
			String requestType, 
			DB_GenericDmlMock fakeGenericDml
		) {
		Case maintenanceRequestTemplate = new Case( 
			status = 'Closed', 
			vehicle__c = TEST_VehicleFactory.create(TEST_DummyInsertModeEnum.MOCK).id, 
			equipment__c = TEST_EquipmentFactory.create(TEST_DummyInsertModeEnum.MOCK).id, 
			type = requestType
		);
		Case newMaintenanceRequest = TEST_MaintenanceRequestFactory.create(maintenanceRequestTemplate, TEST_DummyInsertModeEnum.MOCK);		
		List<Case> newMaintenanceRequestList = new List<Case>{newMaintenanceRequest};
		
		DB_WorkPartSelectorMock fakeWorkPartSelector = new DB_WorkPartSelectorMock(DAYS_TIL_NEXT_SERVICE_DUE);
		return new HWR_MaintenanceRequests(newMaintenanceRequestList, fakeGenericDml, fakeWorkPartSelector);
	}
	
	// --------------------------------------------------------------------------------------------------------------
	
	@isTest static void testSelectDueDateShouldUseLowestMaintenanceCycleToReturnDate() {
		// Arrange
		DB_GenericDmlMock fakeGenericDml = new DB_GenericDmlMock();  
		HWR_MaintenanceRequests targetClass = initializeMaintenanceRequests('', fakeGenericDml);
		
		Case maintenanceRequest = targetClass.maintenanceRequestList[0].clone(true, true, true, true);
		List<Product2> equipmentTemplateList = new List<Product2>{
			new Product2(maintenance_cycle__c = DAYS_TIL_NEXT_SERVICE_DUE),
			new Product2(maintenance_cycle__c = DAYS_TIL_NEXT_SERVICE_DUE + 1),
			new Product2(maintenance_cycle__c = DAYS_TIL_NEXT_SERVICE_DUE + 10)
		}; 
		List<Product2> equipmentList = TEST_EquipmentFactory.createList(equipmentTemplateList, TEST_DummyInsertModeEnum.MOCK);
		Work_Part__c workPartTempate = new Work_Part__c(maintenance_request__c = maintenanceRequest.id);
		List<Work_Part__c> workPartList = TEST_WorkPartFactory.createList(workPartTempate, equipmentList, TEST_DummyInsertModeEnum.MOCK);  
		
		// Act
		Date resultDate;  
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultDate = targetClass.selectDueDate(maintenanceRequest, workPartList);
            }
            Test.stopTest();
        } 

		// Assert
		System.assertEquals(Date.today().addDays((Integer) DAYS_TIL_NEXT_SERVICE_DUE), resultDate);
	}

	@isTest static void testSelectDueDateShouldDefaultToYear4000() {
		// Arrange
		DB_GenericDmlMock fakeGenericDml = new DB_GenericDmlMock();  
		HWR_MaintenanceRequests targetClass = initializeMaintenanceRequests('', fakeGenericDml);
		
		Case maintenanceRequest = targetClass.maintenanceRequestList[0].clone(true, true, true, true);
		List<Work_Part__c> workPartList = new List<Work_Part__c>();  
		
		// Act
		Date resultDate;  
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultDate = targetClass.selectDueDate(maintenanceRequest, workPartList);
            }
            Test.stopTest();
        } 

		// Assert
		System.assertEquals(4000, resultDate.year());
	}
	
}