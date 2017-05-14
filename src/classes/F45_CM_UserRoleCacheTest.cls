@isTest
public with sharing class F45_CM_UserRoleCacheTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();

	private static final String EXPECTED_USER_ROLE_NAME = 'All Star'; 
	private static final UserRole EXPECTED_USER_ROLE = F45_FTY_TestUserRoleFactory.create(EXPECTED_USER_ROLE_NAME, F45_FTY_RecordInsertMode.MOCK);
	private static final List<UserRole> EXPECTED_USER_ROLE_LIST = new List<UserRole>{EXPECTED_USER_ROLE};
	private static final F45_SEL_UserRoleSelector MOCK_USER_ROLE_SELECTOR = new F45_SEL_UserRoleSelectorMock(EXPECTED_USER_ROLE_LIST); 
	private static final F45_CM_UserRoleCache CACHE_UNDER_TEST = new F45_CM_UserRoleCache(MOCK_USER_ROLE_SELECTOR); 
	
	@isTest public static void testBuildUserRoleByNameMapShouldPopulateTheMap() {
		// Arrange
		// Nothing to do here
		 
		// Act
		Map<String, UserRole> resultMap;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultMap = CACHE_UNDER_TEST.buildUserRoleByNameMap();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultMap.size());
		System.assertEquals(EXPECTED_USER_ROLE, resultMap.get(EXPECTED_USER_ROLE_NAME));
	}
	    
	@isTest public static void testGetByNameShouldReturnAppropriateUserRole() {
		// Arrange
		// Nothing to do here
		
		// Act
		UserRole resultUserRole;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultUserRole = CACHE_UNDER_TEST.getByName(EXPECTED_USER_ROLE_NAME);
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(EXPECTED_USER_ROLE, resultUserRole);
	}    
}