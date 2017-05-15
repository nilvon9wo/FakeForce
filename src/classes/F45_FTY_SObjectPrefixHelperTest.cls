@isTest
public with sharing class F45_FTY_SObjectPrefixHelperTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	@isTest public static void testGetReturnsAppropriatePrefix() {
    	// Arrange
		// Nothing to do here
    	
    	// Act
    	String result;
    	Test.startTest();
    	System.runAs(TEST_RUNNER) {
			result = F45_FTY_SObjectPrefixHelper.get(Account.SObjectType); 
    	}
    	Test.stopTest();

    	// Assert
    	System.assertEquals(Account.SObjectType.getDescribe().getKeyPrefix(), result);
	}    
}