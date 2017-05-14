@isTest
public with sharing class F45_DML_GenericDmlIntTest {
	private static final User TEST_RUNNER = F45_FTY_TestUserFactory.createTestRunner();
	private static final F45_DML_GenericDml DML_HANDLER = new F45_DML_GenericDml();
	
	// Insert Tests -------------------------------------------------------------------------------------------------

	@isTest public static void testDoInsertShouldReturnAppropriateWrappedResult() {
		// Arrange
		Account testAccount = new Account();
		Boolean isAllOrNone = false;
		
		// Act
		F45_DML_SaveResultListWrapper resultListWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultListWrapper = DML_HANDLER.doInsert(new List<Account>{testAccount}, isAllOrNone);
		}
		Test.stopTest();
		
		// Assert
		List<F45_DML_SaveResultWrapper> resultWrapperList = resultListWrapper.getResultWrapperList();
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_SaveResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(null, resultWrapper.getId());
		System.assertEquals(false, resultWrapper.isSuccess());
		System.assertEquals(1, resultWrapper.getErrorList().size());
	}
	
	
	@isTest public static void testDoInsertShouldBeAllOrNoneByDefault() {
		// Arrange
		Account testAccount = new Account();
		
		// Act
		Boolean exceptionCaught = false;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			try {
				DML_HANDLER.doInsert(new List<Account>{testAccount});
			}
			catch (System.DmlException ex) {
				System.assert(ex.getMessage().contains('REQUIRED_FIELD_MISSING'));
				exceptionCaught = true;
			}
		}
		Test.stopTest();
		
		// Assert
		System.assert(exceptionCaught);
	}  

	// Update Tests -------------------------------------------------------------------------------------------------

	@isTest public static void testDoUpdateShouldReturnAppropriateWrappedResult() {
		// Arrange
		Account testAccount = new Account();
		Boolean isAllOrNone = false;
		
		// Act
		F45_DML_SaveResultListWrapper resultListWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultListWrapper = DML_HANDLER.doUpdate(new List<Account>{testAccount}, isAllOrNone);
		}
		Test.stopTest();
		
		// Assert
		List<F45_DML_SaveResultWrapper> resultWrapperList = resultListWrapper.getResultWrapperList();
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_SaveResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(null, resultWrapper.getId());
		System.assertEquals(false, resultWrapper.isSuccess());
		System.assertEquals(1, resultWrapper.getErrorList().size());
	}
	
	
	@isTest public static void testDoUpdateShouldBeAllOrNoneByDefault() {
		// Arrange
		Account testAccount = new Account();
		
		// Act
		Boolean exceptionCaught = false;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			try {
				DML_HANDLER.doUpdate(new List<Account>{testAccount});
			}
			catch (System.DmlException ex) {
				System.assert(ex.getMessage().contains('MISSING_ARGUMENT'));
				exceptionCaught = true;
			}
		}
		Test.stopTest();
		
		// Assert
		System.assert(exceptionCaught);
	}  

	// Upsert Tests -------------------------------------------------------------------------------------------------

	@isTest public static void testDoUpsertShouldReturnAppropriateWrappedResult() {
		// Arrange
		Account testAccount = new Account();
		Boolean isAllOrNone = false;
		
		// Act
		F45_DML_UpsertResultListWrapper resultListWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultListWrapper = DML_HANDLER.doUpsert(new List<Account>{testAccount}, isAllOrNone);
		}
		Test.stopTest();
		
		// Assert
		List<F45_DML_UpsertResultWrapper> resultWrapperList = resultListWrapper.getResultWrapperList();
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_UpsertResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(null, resultWrapper.getId());
		System.assertEquals(false, resultWrapper.isSuccess());
		System.assertEquals(1, resultWrapper.getErrorList().size());
	}
	
	
	@isTest public static void testDoUpsertShouldBeAllOrNoneByDefault() {
		// Arrange
		Account testAccount = new Account();
		
		// Act
		Boolean exceptionCaught = false;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			try {
				DML_HANDLER.doUpsert(new List<Account>{testAccount});
			}
			catch (System.DmlException ex) {
				System.assert(ex.getMessage().contains('REQUIRED_FIELD_MISSING'));
				exceptionCaught = true;
			}
		}
		Test.stopTest();
		
		// Assert
		System.assert(exceptionCaught);
	}  	

	// Delete Tests -------------------------------------------------------------------------------------------------
	// Note: I would have prefered to test a failing operation, but Database.delete only handles DMLExceptions.
	// 			Anything I could think to do to sabotage the deletion set off a different Exception.
	//			Maybe if we set two objects with a master-detail relationship, deleting the master might fail in a desired way...
	//			But I don't want to manipulate the org to make this test...

	@isTest public static void testDoDeleteShouldReturnAppropriateWrappedResult() {
		// Arrange
		Account testAccount = F45_FTY_TestAccountFactory.create(F45_FTY_RecordInsertMode.REAL);
		Id testAccountId = testAccount.id;
		Boolean isAllOrNone = false;
		
		// Act
		F45_DML_DeleteResultListWrapper resultListWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultListWrapper = DML_HANDLER.doDelete(new List<Account>{testAccount}, isAllOrNone);
		}
		Test.stopTest();
		
		// Assert
		List<F45_DML_DeleteResultWrapper> resultWrapperList = resultListWrapper.getResultWrapperList();
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_DeleteResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testAccountId, resultWrapper.getId());
		System.assertEquals(true, resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}
	
	
	@isTest public static void testDoDeleteShouldBeShouldReturnAppropriateWrappedResultByDefault() {
		// Arrange
		Account testAccount = F45_FTY_TestAccountFactory.create(F45_FTY_RecordInsertMode.REAL);
		Id testAccountId = testAccount.id;
		
		// Act
		F45_DML_DeleteResultListWrapper resultListWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultListWrapper = DML_HANDLER.doDelete(new List<Account>{testAccount});
		}
		Test.stopTest();
		
		// Assert
		List<F45_DML_DeleteResultWrapper> resultWrapperList = resultListWrapper.getResultWrapperList();
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_DeleteResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testAccountId, resultWrapper.id);
		System.assertEquals(true, resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}  	

	// Undelete Tests -------------------------------------------------------------------------------------------------
	// Note: I would have prefered to test a failing operation, but I'm not aware of any condition which would prevent undelete.
	//		Maybe if the object to be deleted needs a unique value which has subsequently been taken?
	//		But I don't want to manipulate the org to make this test...

	@isTest public static void testDoUndeleteShouldReturnAppropriateWrappedResult() {
		// Arrange
		Account testAccount = F45_FTY_TestAccountFactory.create(F45_FTY_RecordInsertMode.REAL);
		Id testAccountId = testAccount.id;
		delete (testAccount);
		Boolean isAllOrNone = false;
		
		// Act
		F45_DML_UndeleteResultListWrapper resultListWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultListWrapper = DML_HANDLER.doUndelete(new List<Account>{testAccount}, isAllOrNone);
		}
		Test.stopTest();
		
		// Assert
		List<F45_DML_UndeleteResultWrapper> resultWrapperList = resultListWrapper.getResultWrapperList();
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_UndeleteResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testAccountId, resultWrapper.getId());
		System.assertEquals(true, resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}
	
	
	@isTest public static void testDoUndeleteShouldBeAllOrNoneByDefault() {
		// Arrange
		Account testAccount = F45_FTY_TestAccountFactory.create(F45_FTY_RecordInsertMode.REAL);
		Id testAccountId = testAccount.id;
		delete (testAccount);
		
		// Act
		F45_DML_UndeleteResultListWrapper resultListWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultListWrapper = DML_HANDLER.doUndelete(new List<Account>{testAccount});
		}
		Test.stopTest();
		
		// Assert
		List<F45_DML_UndeleteResultWrapper> resultWrapperList = resultListWrapper.getResultWrapperList();
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_UndeleteResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testAccountId, resultWrapper.getId());
		System.assertEquals(true, resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}  	  
}