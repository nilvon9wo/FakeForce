@isTest 
public class F45_FTY_TestUserRoleFactory extends F45_FTY_SObjectFactory {
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
	};  
	
	public static List<UserRole> createList(UserRole template, Integer quantity, F45_FTY_RecordInsertMode insertMode){
		SObjectTemplateStrategyInterface strategy = new UserRoleInQuantityStrategy(template, quantity); 
		return (List<UserRole>) F45_FTY_TestSObjectFactory.createTestList(strategy, insertMode); 
	}
	
	public static UserRole create(UserRole template, F45_FTY_RecordInsertMode insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static UserRole create(String roleName, F45_FTY_RecordInsertMode insertMode){
		UserRole template = new UserRole(name = roleName);
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	class UserRoleInQuantityStrategy extends SObjectInQuantityStrategy {
		UserRoleInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'UserRole ', defaultByKeyMap);
		}
	}
}