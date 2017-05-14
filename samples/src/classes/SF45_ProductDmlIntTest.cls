@isTest 
private class SF45_ProductDmlIntTest {
	private static final User TestRunner = F45_FTY_TestUserFactory.createTestRunner(); 
	
	@isTest static void testDoUpsertUsingSkuAsExternalKeyShouldUpdateProductByWarehouseSkuValue() {
		// Arrange
		SDAO_ProductDml targetClass = new SDAO_ProductDml();  

		String testWarehouseSku = 'CM01-R';
		Product2 template = new Product2(warehouse_sku__c = testWarehouseSku, cost__c = 1999);
		SF45_ProductFactory.create(template, F45_FTY_RecordInsertMode.REAL); 

		Product2 updatedProduct = new Product2(warehouse_sku__c = testWarehouseSku, cost__c = 3422); 
		
		// Act
		Database.UpsertResult[] resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultList = targetClass.doUpsertUsingSkuAsExternalKey(new List<Product2>{ updatedProduct });
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(true, resultList[0].isSuccess()); 
		
		List<Product2> resultProductList = [SELECT cost__c FROM Product2 WHERE warehouse_sku__c = :testWarehouseSku]; 		
		System.assertEquals(1, resultProductList.size());
		System.assertEquals(updatedProduct.cost__c, resultProductList[0].cost__c);
	}
}