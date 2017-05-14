@isTest
public with sharing class F45_DML_DeleteResultListWrapperIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	@isTest public static void testGetResultWrapperListShouldReturnListWithExpectedProperties() {
		// Arrange
		UserRole testUserRole = F45_FTY_TestUserRoleFactory.create(F45_FTY_RecordInsertMode.REAL);
		Boolean notAllOrNone = false;
		Database.DeleteResult testDeleteResult = Database.delete(testUserRole, notAllOrNone); 
		List<Database.DeleteResult> testDeleteResultList = new List<Database.DeleteResult>{testDeleteResult}; 
		F45_DML_DeleteResultListWrapper wrapperUnderTest = new F45_DML_DeleteResultListWrapper(testDeleteResultList);				
		
		// Act
		List<F45_DML_DeleteResultWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = wrapperUnderTest.getResultWrapperList();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_DeleteResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testDeleteResult.id, resultWrapper.id);
		System.assertEquals(testDeleteResult.isSuccess(), resultWrapper.wasSuccess);
		System.assert(resultWrapper.errorList.isEmpty());
	}
}