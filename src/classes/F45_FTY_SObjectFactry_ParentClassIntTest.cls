@isTest
public with sharing class F45_FTY_SObjectFactry_ParentClassIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	private static final User EXPECTED_USER = F45_FTY_TestUserFactory.create(F45_FTY_RecordInsertMode.NONE);

    @isTest public static void testDefaultConstructorDoesNotAllowMockInsertions(){
    	// Arrange
    	// Nothing to do here
    	
    	// Act
		F45_FTY_SObjectFactory resultFactory; 
    	Test.startTest();
    	System.runAs(TEST_RUNNER) {
    		resultFactory = new F45_FTY_SObjectFactory();
    	}
    	Test.stopTest();

    	// Assert
    	Boolean caughtException = false;
    	try {
    		resultFactory.createList(new TestTemplateStrategy(), F45_FTY_RecordInsertMode.MOCK);
    	}
    	catch (F45_FTY_SObjectFactoryDmlException ex) {
    		caughtException = true;
    	}
		System.assert(caughtException);
    }

    private class TestTemplateStrategy implements F45_FTY_SObjectFactory.SObjectTemplateStrategyInterface {
    	public List<SObject> execute(List<SObject> mockSObjectList) {
    		mockSObjectList.add(EXPECTED_USER);
    		return mockSObjectList;
    	} 
    }

}