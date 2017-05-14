@isTest
public with sharing class F45_DML_UndeleteResultWrapperIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	private static final Database.UndeleteResult UNDELETE_RESULT = createUndeleteResult();
	private static final F45_DML_UndeleteResultWrapper WRAPPER_UNDER_TEST = new F45_DML_UndeleteResultWrapper(UNDELETE_RESULT);
    
	@isTest public static void testGetIdShouldReturnAppropriateId() {
		// Arrange
		// Nothing to do here
				
		// Act
		Id resultId;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultId = WRAPPER_UNDER_TEST.getId();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(UNDELETE_RESULT.id, resultId);
	}

	@isTest public static void testIsSuccessShouldReturnAppropriateStatus() {
		// Arrange
		// Nothing to do here
				
		// Act
		Boolean result;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			result = WRAPPER_UNDER_TEST.isSuccess();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(UNDELETE_RESULT.isSuccess(), result);
	}

	@isTest public static void testGetErrorListShouldReturnAppropriateResult() {
		// Arrange
		// Nothing to do here
				
		// Act
		List<F45_DML_DatabaseErrorWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = WRAPPER_UNDER_TEST.getErrorList();
		}
		Test.stopTest();
		
		// Assert
		System.assert(resultWrapperList.isEmpty());
	}
    
	@isTest public static void testWrapperConstructionShouldBePossibleWithoutASeedError() {
		// Arrange
		// Nothing to do here
		
		// Act
		F45_DML_UndeleteResultWrapper resultWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapper = new F45_DML_UndeleteResultWrapper();
		}
		Test.stopTest();
		
		// Assert
		System.assertNotEquals(null, resultWrapper);
	}	
    
    private static Database.UndeleteResult createUndeleteResult() {
		Account testAccount = F45_FTY_TestAccountFactory.create(F45_FTY_RecordInsertMode.REAL);
		Id testAccountId = testAccount.id;
		delete testAccount;
		Boolean notAllOrNone = false;
		return Database.undelete(testAccountId, notAllOrNone); 
    }
}