@isTest 
public class F45_FTY_TestAccountFactory extends F45_FTY_SObjectFactory {
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
	};  
	
	public static List<Account> createList(Account template, Integer quantity, F45_FTY_RecordInsertMode insertMode){
		SObjectTemplateStrategyInterface strategy = new AccountInQuantityStrategy(template, quantity); 
		return (List<Account>) F45_FTY_TestSObjectFactory.createTestList(strategy, insertMode); 
	}
	
	public static Account create(Account template, F45_FTY_RecordInsertMode insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static Account create(String name, F45_FTY_RecordInsertMode insertMode){
		Account template = new Account(name = name);
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static Account create(F45_FTY_RecordInsertMode insertMode){
		return create(new Account(), insertMode);
	}

	class AccountInQuantityStrategy extends SObjectInQuantityStrategy {
		AccountInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Account ', defaultByKeyMap);
		}
	}
}