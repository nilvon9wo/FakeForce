@isTest
private class SF45_MaintenanceRequestHelperTest { 
	private static final User TestRunner = F45_FTY_TestUserFactory.createTestRunner(); 
	
	@isTest static void onAfterUpdateShouldUpdateWorkOrders(){
		// Arrange
		List<Case> maintenanceRequestList = new List<Case>();   
		SF45_MaintenanceRequestsMock maintenanceRequestMock = new SF45_MaintenanceRequestsMock(maintenanceRequestList); 
		SPRD_MaintenanceRequestHelper targetClass = new SPRD_MaintenanceRequestHelper(maintenanceRequestList, maintenanceRequestMock);
		Map<Id,SObject> existingMaintenanceRequestMap = null; 
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
                targetClass.onAfterUpdate(existingMaintenanceRequestMap);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(true, maintenanceRequestMock.workOrdersWereUpdated);
	}
}