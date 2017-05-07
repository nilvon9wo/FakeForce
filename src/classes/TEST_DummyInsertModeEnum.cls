// @isTest , but SFDC won't let us annotate enum that was. 
public enum TEST_DummyInsertModeEnum 
{
	NONE,	// Use if SObject will NOT be used in any DML, SOQL, etc. operations.
	MOCK,	// Ibid., but an SObject Id is required for some tests.
	REAL,	// Use if SObject MUST IMMEDIATELY be inserted.
	LATER	// Ensures related objects do NOT get mock Ids: Use if either the SObject itself or other related SObjects will be used in any DML, SOQL, etc. operations.
}