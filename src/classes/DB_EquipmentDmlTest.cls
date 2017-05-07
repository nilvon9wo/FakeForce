@isTest 
private class DB_EquipmentDmlTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void testDoUpsertUsingSkuAsExternalKeyShouldUpdateEquipmentByWarehouseSkuValue() {
		// Arrange
		DB_EquipmentDml targetClass = new DB_EquipmentDml();

		String testWarehouseSku = 'CM01-R';
		Product2 template = new Product2(warehouse_sku__c = testWarehouseSku, cost__c = 1999);
		TEST_EquipmentFactory.create(template, TEST_DummyInsertModeEnum.REAL);

		Product2 updatedEquipment = new Product2(warehouse_sku__c = testWarehouseSku, cost__c = 3422); 
		
		// Act
		Database.UpsertResult[] resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultList = targetClass.doUpsertUsingSkuAsExternalKey(new List<Product2>{ updatedEquipment });
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(true, resultList[0].isSuccess());
		
		List<Product2> resultEquipmentList = [SELECT cost__c FROM Product2 WHERE warehouse_sku__c = :testWarehouseSku]; 		
		System.assertEquals(1, resultEquipmentList.size());
		System.assertEquals(updatedEquipment.cost__c, resultEquipmentList[0].cost__c);
	}
}