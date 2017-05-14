/**
 *  Anticipated Questions and anwsers
 *
 *  Q: Does FakeForce distinguish between the NONE and LATER values?
 *  A: No.
 *
 *  Q: Why include both NONE and LATER values?
 *  A: Because it can be prove useful, either for tests which leverage F45, or for developers reading the source code.
 *
 *	Q: Can I use REAL in a unit test?
 *  A: No, that would be an integration test.
 *
 *  Q: Can I mix REAL and MOCK values in the same test?
 *  A: Maybe, but you may have unexpected results when the two sObjects interact, particularly if there is DML.
 **/
// @isTest , but SFDC won't let us annotate enum that was. 
public enum F45_FTY_RecordInsertMode 
{
	NONE,	// Use if SObject will NOT be used in any DML, SOQL, etc. operations.
	MOCK,	// Ibid., but an SObject Id is required for some tests.
	REAL,	// Use if SObject MUST IMMEDIATELY be inserted.
	LATER	// Ensures related objects do NOT get mock Ids: Use if either the SObject itself or other related SObjects will be used in any DML, SOQL, etc. operations.
}