// This needs to be an integration test because SFDC won't let us write to the Profile name field.
@isTest
public with sharing class F45_CM_ProfileCacheIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	private static final List<Profile> EXPECTED_PROFILE_LIST = [ SELECT id, name FROM Profile LIMIT 1 ];
	private static final F45_SEL_ProfileSelector MOCK_PROFILE_SELECTOR = new F45_SEL_ProfileSelectorMock(EXPECTED_PROFILE_LIST); 
	private static final F45_CM_ProfileCache CACHE_UNDER_TEST = new F45_CM_ProfileCache(MOCK_PROFILE_SELECTOR); 
	private static final Profile EXPECTED_PROFILE = EXPECTED_PROFILE_LIST[0];
	private static final String EXPECTED_PROFILE_NAME = EXPECTED_PROFILE.name;

	@isTest public static void testLoadProfileByNameMapShouldPopulateTheMap() {
		// Arrange
		// Nothing to do here
		
		// Act
		Map<String, Profile> resultMap;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultMap = CACHE_UNDER_TEST.buildProfileByNameMap();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultMap.size());
		System.assertEquals(EXPECTED_PROFILE, resultMap.get(EXPECTED_PROFILE_NAME));
	}
	    
	@isTest public static void testGetByNameShouldReturnAppropriateProfile() {
		// Arrange
		// Nothing to do here
		
		// Act
		Profile resultProfile;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultProfile = CACHE_UNDER_TEST.getByName(EXPECTED_PROFILE_NAME);
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(EXPECTED_PROFILE, resultProfile);
	}    
}