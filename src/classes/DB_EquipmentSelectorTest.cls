@isTest  
private class DB_EquipmentSelectorTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void testSelectById() {
		// Arrange
		DB_EquipmentSelector targetClass = new DB_EquipmentSelector();

		Product2 template = new Product2(maintenance_cycle__c = 1999);
		Product2 testEquipment = TEST_EquipmentFactory.create(template, TEST_DummyInsertModeEnum.REAL);
		
		// Act
		List<Product2> resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultList = targetClass.selectById(new Set<Id>{ testEquipment.id });
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(1, resultList.size());
		System.assertEquals(template.maintenance_cycle__c, resultList[0].maintenance_cycle__c);
	}
}