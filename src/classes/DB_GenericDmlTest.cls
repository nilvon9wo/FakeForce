@isTest 
private class DB_GenericDmlTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void testDoInsert(){
		// Arrange
		DB_GenericDml targetClass = new DB_GenericDml();
		
		String testWarehouseSku = 'CM01-R';
		Product2 template = new Product2(warehouse_sku__c = testWarehouseSku, cost__c = 1999);
		Product2 newEquipment = TEST_EquipmentFactory.create(template, TEST_DummyInsertModeEnum.LATER);
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
                targetClass.doInsert(new List<Product2>{ newEquipment });
            }
            Test.stopTest();
        }

		// Assert
		List<Product2> resultEquipmentList = [SELECT cost__c FROM Product2 WHERE warehouse_sku__c = :testWarehouseSku]; 		
		System.assertEquals(1, resultEquipmentList.size());
		System.assertEquals(newEquipment.cost__c, resultEquipmentList[0].cost__c);
	}
}