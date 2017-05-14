@isTest
public with sharing class F45_DML_DatabaseErrorHelperIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	private static final F45_DML_DatabaseErrorHelper HELPER_UNDER_TEST = new F45_DML_DatabaseErrorHelper();

	@isTest public static void testConvertShouldReturnAppropriateList() {
		// Arrange
		Account account = new Account();
		Boolean notAllOrNone = false;
		Database.SaveResult saveResult = Database.insert(account, notAllOrNone);
		Database.Error testError = saveResult.getErrors()[0]; 
		
		// Act
		List<F45_DML_DatabaseErrorWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = HELPER_UNDER_TEST.convert(new List<Database.Error>{testError});
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		F45_DML_DatabaseErrorWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testError.getFields(), resultWrapper.fieldList);
		System.assertEquals(testError.getMessage(), resultWrapper.message);
		System.assertEquals(testError.getStatusCode(), resultWrapper.statusCode);
	}

	@isTest public static void testConvertShouldReturnNullWhenNullInput() {
		// Arrange
		// Nothing to do here
		
		// Act
		List<F45_DML_DatabaseErrorWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = HELPER_UNDER_TEST.convert(null);
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(null, resultWrapperList);
	}
}