@isTest
public with sharing class F45_FTY_SObjectFty_PerTemplateTests {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	
	@isTest public static void testExecutsCreatesListOfSpecifiedSObjects2() {
    	// Arrange
		User strategyTemplate = F45_FTY_TestUserFactory.create(F45_FTY_RecordInsertMode.NONE);
		List<User> strategyTemplateList = new List<User>{strategyTemplate};
    	String defaultName = 'Fred';

		F45_FTY_SObjectFactory.SObjectPerTemplateStrategy strategyUnderTest 
			= new F45_FTY_SObjectFactory.SObjectPerTemplateStrategy(strategyTemplateList, defaultName);
    	
    	List<SObject> sObjectList = new List<SObject>(); 

    	// Act
    	List<SObject> resultList;
    	Test.startTest();
    	System.runAs(TEST_RUNNER) {
			resultList = strategyUnderTest.execute(sObjectList); 
    	}
    	Test.stopTest();

    	// Assert
    	System.assertEquals(sObjectList, resultList);
    	System.assertEquals(1, resultList.size());
    	
    	User resultUser = (User) resultList[0];
    	System.assert(resultUser.LastName.contains('User'));
    	System.assert(resultUser.Email.contains(F45_FTY_TestUserFactory.OTHER_USER_NAME_SEED));
    	System.assert(resultUser.Username.contains(F45_FTY_TestUserFactory.OTHER_USER_NAME_SEED));
    	System.assert(resultUser.CommunityNickname.contains(F45_FTY_TestUserFactory.OTHER_USER_NAME_SEED));
    	System.assertEquals(F45_FTY_TestUserFactory.DEFAULT_USER_PROFILE_ID, resultUser.ProfileId);
    	System.assertEquals(F45_FTY_TestUserFactory.DEFAULT_USER_ROLE_ID, resultUser.UserRoleId);
    	System.assertEquals(F45_FTY_TestUserFactory.DEFAULT_EMAIL_ENCODING, resultUser.EmailEncodingKey);
    	System.assertEquals(F45_FTY_TestUserFactory.DEFAULT_LANGUAGE_ENCODING, resultUser.LanguageLocaleKey);
    	System.assertEquals(F45_FTY_TestUserFactory.DEFAULT_LOCALE, resultUser.LocaleSidKey);
    	System.assertEquals(F45_FTY_TestUserFactory.DEFAULT_TIME_ZONE, resultUser.TimeZoneSidKey);
    }   
    
}