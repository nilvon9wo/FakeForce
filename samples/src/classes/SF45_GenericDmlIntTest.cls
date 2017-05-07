@isTest 
private class SF45_GenericDmlIntTest {
	private static final User TestRunner = F45_RunAsUserFactory.create(); 
	
	@isTest static void testDoInsert(){
		// Arrange
		SDAO_GenericDml targetClass = new SDAO_GenericDml(); 
		
		String testWarehouseSku = 'CM01-R';
		Product2 template = new Product2(warehouse_sku__c = testWarehouseSku, cost__c = 1999);
		Product2 newEquipment = SF45_ProductFactory.create(template, F45_DummyInsertMode.LATER);
		
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