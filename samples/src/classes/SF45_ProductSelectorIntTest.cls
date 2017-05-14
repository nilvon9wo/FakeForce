@isTest  
private class SF45_ProductSelectorIntTest {
	private static final User TestRunner = F45_FTY_RunAsUserFactory.create(); 
	
	@isTest static void testSelectById() {
		// Arrange
		SDAO_ProductSelector targetClass = new SDAO_ProductSelector(); 

		Product2 template = new Product2(maintenance_cycle__c = 1999);
		Product2 testProduct = SF45_ProductFactory.create(template, F45_FTY_DummyInsertMode.REAL);
		
		// Act
		List<Product2> resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultList = targetClass.selectById(new Set<Id>{ testProduct.id });
            }
            Test.stopTest();
        }

		// Assert
		System.assert(resultList != null);
		System.assertEquals(1, resultList.size());
		System.assertEquals(template.maintenance_cycle__c, resultList[0].maintenance_cycle__c);
	}
}