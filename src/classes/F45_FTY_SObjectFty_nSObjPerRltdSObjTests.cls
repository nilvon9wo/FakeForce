@isTest
public with sharing class F45_FTY_SObjectFty_nSObjPerRltdSObjTests {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	
	private static final Account STRATEGY_TEMPLATE = new Account();
	private static final Integer STRATEGY_QUANTITY = 2;
	private static final String DEFAULT_NAME = 'Sona Jobarteh';
	private static final String RELATED_FIELD = 'OwnerId';
	private static final Integer RELATED_OBJECT_QUANTITY = 3;
	private static final User OWNER_TEMPLATE = new User();
	private static final List<SObject> RELATED_OBJECT_LIST
		 = F45_FTY_TestUserFactory.createList(OWNER_TEMPLATE, RELATED_OBJECT_QUANTITY, F45_FTY_RecordInsertMode.MOCK);
	
	private static final F45_FTY_SObjectFactory.SObjectInQuantityStrategy STRATEGY_UNDER_TEST 
		= new F45_FTY_SObjectFactory.nSObjectPerRelatedSObjectStrategy(
			STRATEGY_TEMPLATE, STRATEGY_QUANTITY, DEFAULT_NAME, RELATED_FIELD, RELATED_OBJECT_LIST
		); 

    @isTest public static void testExecutsCreatesListOfSpecifiedSObjects() {
    	// Arrange
    	List<Account> testAccountList = new List<Account>();
    	
    	// Act
    	List<SObject> resultList; 
    	Test.startTest();
    	System.runAs(TEST_RUNNER) {
			resultList = STRATEGY_UNDER_TEST.execute(testAccountList); 
    	}
    	Test.stopTest();

    	// Assert
    	System.assertEquals(testAccountList, resultList);
    	System.assertEquals(STRATEGY_QUANTITY * RELATED_OBJECT_QUANTITY, resultList.size());
    	
    	Set<Id> idSet = new Set<Id>(); 
    	for (SObject result : resultList) {
    		String name = (String)result.get('name');
    		System.assert(name.contains(DEFAULT_NAME));
    		idSet.add((Id) result.get(RELATED_FIELD));
    	}
    	System.assertEquals(RELATED_OBJECT_QUANTITY, idSet.size());
    }
}