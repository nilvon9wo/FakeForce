@isTest
public with sharing class F45_DML_SaveResultListWrapperIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	@isTest public static void testGetResultWrapperListShouldReturnListWithExpectedProperties() {
		// Arrange
		UserRole testUserRole = F45_FTY_TestUserRoleFactory.create(F45_FTY_RecordInsertMode.LATER);
		Boolean notAllOrNone = false;
		Database.SaveResult testSaveResult = Database.insert(testUserRole, notAllOrNone); 
		List<Database.SaveResult> testSaveResultList = new List<Database.SaveResult>{testSaveResult}; 
		F45_DML_SaveResultListWrapper wrapperUnderTest = new F45_DML_SaveResultListWrapper(testSaveResultList);				
		
		// Act
		List<F45_DML_SaveResultWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = wrapperUnderTest.getResultWrapperList();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_SaveResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testSaveResult.id, resultWrapper.id);
		System.assertEquals(testSaveResult.isSuccess(), resultWrapper.wasSuccess);
		System.assert(resultWrapper.errorList.isEmpty());
	}
}