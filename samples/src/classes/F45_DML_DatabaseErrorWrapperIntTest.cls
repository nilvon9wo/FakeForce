@isTest
public with sharing class F45_DML_DatabaseErrorWrapperIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	@isTest public static void testWrapperShouldContainExpectedPropertiesAfterConstruction() {
		// Arrange
		Account account = new Account();
		Boolean notAllOrNone = false;
		Database.SaveResult saveResult = Database.insert(account, notAllOrNone);
		Database.Error testError = saveResult.getErrors()[0]; 
		
		// Act
		F45_DML_DatabaseErrorWrapper resultWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapper = new F45_DML_DatabaseErrorWrapper(testError);
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(testError.getFields(), resultWrapper.fieldList);
		System.assertEquals(testError.getMessage(), resultWrapper.message);
		System.assertEquals(testError.getStatusCode(), resultWrapper.statusCode);
	}
	
	@isTest public static void testWrapperConstructionShouldBePossibleWithoutASeedError() {
		// Arrange
		// Nothing to do here
		
		// Act
		F45_DML_DatabaseErrorWrapper resultWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapper = new F45_DML_DatabaseErrorWrapper();
		}
		Test.stopTest();
		
		// Assert
		System.assertNotEquals(null, resultWrapper);
	}	
}