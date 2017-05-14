@isTest
public with sharing class F45_FTY_TestSObjectFactory extends F45_FTY_SObjectFactory {
    public F45_FTY_TestSObjectFactory() {
    	super(new F45_FTY_DmlForTestHelper());
    }
    
    public static List<SObject> createTestList (SObjectTemplateStrategyInterface templateStrategy, F45_FTY_RecordInsertMode insertMode) {
    	return (new F45_FTY_TestSObjectFactory()).createList(templateStrategy, insertMode);
	}
}