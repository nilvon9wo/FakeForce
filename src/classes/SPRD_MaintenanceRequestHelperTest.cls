@isTest
private class MaintenanceRequestHelperTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void onAfterUpdateShouldUpdateWorkOrders(){
		// Arrange
		List<Case> maintenanceRequestList = new List<Case>();   
		SPRD_MaintenanceRequestsMock maintenanceRequestMock = new SPRD_MaintenanceRequestsMock(maintenanceRequestList); 
		MaintenanceRequestHelper targetClass = new MaintenanceRequestHelper(maintenanceRequestList, maintenanceRequestMock);
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