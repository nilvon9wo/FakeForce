@isTest
public with sharing class F45_SEL_ProfileSelectorIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	@isTest public static void testBuildProfileByNameMapShouldPopulateTheMap() {
		// Arrange
		F45_SEL_ProfileSelector selectorUnderTest = new F45_SEL_ProfileSelector();
		
		// Act
		List<Profile> resultList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultList = selectorUnderTest.selectAll();
		}
		Test.stopTest();
		
		// Assert
		Map<Id, Profile> resultByIdMap = new Map<Id, Profile>(resultList);
		Map<Id, Profile> expectedByIdMap = new Map<Id, Profile>([
    		SELECT id, name
    		FROM Profile
		]);

		Set<Id> resultIdSet = resultByIdMap.keySet();
		System.assertEquals(expectedByIdMap.keySet(), resultIdSet);
		for (Id resultId : resultIdSet) {
			System.assertEquals(expectedByIdMap.get(resultId), resultByIdMap.get(resultId));
		}
	}
}