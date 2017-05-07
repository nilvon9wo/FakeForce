@IsTest
private class InstallationTests {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final Integer DAYS_TIL_NEXT_SERVICE_DUE = 35;

    static testmethod void testMaintenanceRequest() {
    	// Arrange
		Case closingMaintenanceRequest = TEST_MaintenanceRequestFactory.createRealClosingMaintenanceRequest('Routine Maintenance');
    	List<Case> newMaintenanceRequestList = new List<Case>{closingMaintenanceRequest};
    	Map<Id,Case> existingMaintenanceRequestMap = new Map<Id,Case>(newMaintenanceRequestList);
    	populateWorkPartSelector(closingMaintenanceRequest.id);
    	
    	// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
                MaintenanceRequestHelper.updateWorkOrders(newMaintenanceRequestList, existingMaintenanceRequestMap);
            }
            Test.stopTest();
        } 
    	
        // Assert
		List<SObject> insertedSObjectList = [
			SELECT vehicle__c, equipment__c, type, subject, date_reported__c, date_due__c
			FROM Case
			WHERE id != :closingMaintenanceRequest.id AND vehicle__c = :closingMaintenanceRequest.vehicle__c
		];
		System.assertEquals(1, insertedSObjectList.size());
		Case insertedCase = (Case)insertedSObjectList[0];
		System.assertEquals(closingMaintenanceRequest.vehicle__c, insertedCase.vehicle__c);
		System.assertEquals(closingMaintenanceRequest.equipment__c, insertedCase.equipment__c);
		System.assertEquals('Routine Maintenance', insertedCase.type);
		System.assertEquals('Routine Maintenance for Vehicle ' + closingMaintenanceRequest.vehicle__c, insertedCase.subject);
		System.assertEquals(Date.today(), insertedCase.date_reported__c);
		System.assertEquals(Date.today().addDays((Integer) DAYS_TIL_NEXT_SERVICE_DUE), insertedCase.date_due__c);
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
    
    // -----------------------------------------------------------------------------------------------
    
    static testmethod void testWarehouseSync() {
		// Arrange
		String name = 'Test Equipment'; 
		String warehouseSku = 'Some Sku 2342';
		Decimal cost = 432;
		Decimal lifespan = 312;
		Decimal maintenancePeriod = 212;
		Decimal quantity = 153;
		Boolean isReplacement = true;
		String testBody = '[{' 
				+ '"name" : "' + name + '",'
				+ '"sku" : "' + warehouseSku + '",'
				+ '"cost" : ' + cost + ','
				+ '"lifespan" : ' + lifespan + ','
				+ '"maintenanceperiod" : ' + maintenancePeriod + ','
				+ '"quantity" : ' + quantity + ','
				+ '"replacement" : ' + isReplacement 
			+ '}]';
		
		Integer successCode = 200;
		Test.setMock(HttpCalloutMock.class, new HTTP_TestRestfulCalloutMock(successCode, testBody));
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
                WarehouseCalloutService.runWarehouseEquipmentSync();
            }
            Test.stopTest();
        }

		// Assert
		List<Product2> updatedEquipmentList = [
			SELECT name, cost__c, lifespan_months__c, maintenance_cycle__c, current_inventory__c, replacement_part__c
			FROM Product2
			WHERE warehouse_sku__c = : warehouseSku
		];
		System.assertEquals(1, updatedEquipmentList.size());
		
		Product2 updatedEquipment = updatedEquipmentList[0];
		System.assertEquals(name, updatedEquipment.name);
		System.assertEquals(cost, updatedEquipment.cost__c);
		System.assertEquals(lifespan, updatedEquipment.lifespan_months__c);
		System.assertEquals(maintenancePeriod, updatedEquipment.maintenance_cycle__c);
		System.assertEquals(quantity, updatedEquipment.current_inventory__c);
		System.assertEquals(isReplacement, updatedEquipment.replacement_part__c);
    }    
}