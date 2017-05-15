@isTest
public with sharing class F45_SEL_UserRoleSelectorIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	@isTest public static void testBuildUserRoleByNameMapShouldPopulateTheMap() {
		// Arrange
		F45_SEL_UserRoleSelector selectorUnderTest = new F45_SEL_UserRoleSelector();
		
		// Act
		List<UserRole> resultList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultList = selectorUnderTest.selectAll();
		}
		Test.stopTest();
		
		// Assert
		Map<Id, UserRole> resultByIdMap = new Map<Id, UserRole>(resultList);
		Map<Id, UserRole> expectedByIdMap = new Map<Id, UserRole>([
    		SELECT id, name
    		FROM UserRole
		]);

		Set<Id> resultIdSet = resultByIdMap.keySet();
		System.assertEquals(expectedByIdMap.keySet(), resultIdSet);
		for (Id resultId : resultIdSet) {
			System.assertEquals(expectedByIdMap.get(resultId), resultByIdMap.get(resultId));
		}
	}
}