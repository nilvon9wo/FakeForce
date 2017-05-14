@isTest
public with sharing class F45_FTY_SObjectFactory_ParentClassTests {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	private static final F45_FTY_SObjectFactory FACTORY_UNDER_TEST = new F45_FTY_SObjectFactory(new F45_FTY_SObjectFactoryMockDml());
	private static final User EXPECTED_USER = F45_FTY_TestUserFactory.create(F45_FTY_RecordInsertMode.NONE);

    @isTest public static void testCreateListShouldCreateAListOfSpecifiedSObjects() {
    	// Arrange
    	F45_FTY_SObjectFactory.SObjectTemplateStrategyInterface testStrategy = new TestTemplateStrategy();
    	F45_FTY_RecordInsertMode testInsertMode = F45_FTY_RecordInsertMode.MOCK;
    	
    	// Act
    	List<SObject> resultList;
    	Test.startTest();
    	System.runAs(TEST_RUNNER) {
    		resultList = FACTORY_UNDER_TEST.createList(testStrategy, testInsertMode);
    	}
    	Test.stopTest();

    	// Assert
    	System.assertEquals(1, resultList.size());
    	SObject result = resultList[0];
		System.assertEquals(EXPECTED_USER, result);
		System.assertNotEquals(null, result.id);    	
    }
    
    @isTest public static void testFillInIfBlankShouldFillInBlankValues() {
    	// Arrange
    	Account testSObject = new Account();
    	String testField = 'name';
    	String testValue = 'Buena Vista Social Club';

    	// Act
    	SObject result;
    	Test.startTest();
    	System.runAs(TEST_RUNNER) {
    		result = F45_FTY_SObjectFactory.fillIfBlank(testSObject, testField, testValue);
    	}
    	Test.stopTest();

    	// Assert
    	System.assertEquals(testValue, result.get(testField));
	}

    @isTest public static void testFillInIfBlankShouldNotOverwriteValues() {
    	// Arrange
    	String originalValue = 'Fatoumata Diawara';
    	Account testSObject = new Account(name = originalValue);
    	String testField = 'name';
    	String testValue = 'Buena Vista Social Club';

    	// Act
    	SObject result;
    	Test.startTest();
    	System.runAs(TEST_RUNNER) {
    		result = F45_FTY_SObjectFactory.fillIfBlank(testSObject, testField, testValue);
    	}
    	Test.stopTest();

    	// Assert
    	System.assertEquals(originalValue, result.get(testField));
    }
    
    private class TestTemplateStrategy implements F45_FTY_SObjectFactory.SObjectTemplateStrategyInterface {
    	public List<SObject> execute(List<SObject> mockSObjectList) {
    		mockSObjectList.add(EXPECTED_USER);
    		return mockSObjectList;
    	} 
    }
} 