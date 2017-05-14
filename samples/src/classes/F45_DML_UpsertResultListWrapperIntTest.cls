@isTest
public with sharing class F45_DML_UpsertResultListWrapperIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	@isTest public static void testGetResultWrapperListShouldReturnListWithExpectedProperties() {
		// Arrange
		UserRole testUserRole = F45_FTY_TestUserRoleFactory.create(F45_FTY_RecordInsertMode.LATER);
		Boolean notAllOrNone = false;
		Database.UpsertResult testUpsertResult = Database.upsert(testUserRole, notAllOrNone); 
		List<Database.UpsertResult> testUpsertResultList = new List<Database.UpsertResult>{testUpsertResult}; 
		F45_DML_UpsertResultListWrapper wrapperUnderTest = new F45_DML_UpsertResultListWrapper(testUpsertResultList);				
		
		// Act
		List<F45_DML_UpsertResultWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = wrapperUnderTest.getResultWrapperList();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_UpsertResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testUpsertResult.id, resultWrapper.getId());
		System.assertEquals(testUpsertResult.isCreated(), resultWrapper.wasCreated);
		System.assertEquals(testUpsertResult.isSuccess(), resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}
}