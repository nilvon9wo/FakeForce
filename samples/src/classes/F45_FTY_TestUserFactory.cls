@isTest 
public class F45_FTY_TestUserFactory extends F45_FTY_SObjectFactory {
	public static final F45_CM_ProfileCache profileCache = new F45_CM_ProfileCache();
	public static final F45_CM_UserRoleCache userRole = new F45_CM_UserRoleCache();
	
	public static final String DEFAULT_USER_PROFILE = 'Standard User';
	public static final String ADMNISTRATOR_PROFILE = 'System Administrator';
	public static final String DEFAULT_USER_ROLE = 'CEO';
	
	private static final Map<String, Object> DEFAULT_VALUES_BY_FIELD_MAP = new Map<String, Object>{
		'ProfileId' => profileCache.getByName(DEFAULT_USER_PROFILE).id,
		'UserRoleId' => userRole.getByName(DEFAULT_USER_ROLE).id,
        'EmailEncodingKey' => 'UTF-8',
        'LanguageLocaleKey' => 'en_US',
        'LocaleSidKey' => 'en_US',
        'TimeZoneSidKey' => 'Europe/Berlin'
	};  
	
    public static User createTestRunner(){
        Integer unique = (Integer) (Math.random() * 999999);
        String testerName = 'Testuser' + unique;
        return createTestRunner(testerName, ADMNISTRATOR_PROFILE, DEFAULT_USER_ROLE);
    }

    public static User createTestRunner(String testerName, String testerProfileString, String testerRoleString){
        User originalAdmin = [ SELECT id FROM User WHERE profile.name = 'System Administrator' ORDER BY CreatedDate LIMIT 1 ];
        System.runAs ( originalAdmin ) {
            User testRunUser = new User(
                 lastName          = testerName,
                 ProfileId         = profileCache.getByName(testerProfileString).id,
                 UserRoleId        = userRole.getByName(testerRoleString).id
            );
            return create(testRunUser, F45_FTY_RecordInsertMode.REAL);
        }
        return originalAdmin;
    }
    
	public static List<User> createList(User templateParam, Integer quantity, F45_FTY_RecordInsertMode insertMode){
		String testerName = templateParam.lastName;

		User template = templateParam.clone();
		template.alias = F45_UTIL_DefaultHelper.ifNullDefault(template.alias, testerName.left(1)+testerName.right(7)); 
		template.email = F45_UTIL_DefaultHelper.ifNullDefault(template.email, testerName + '@f45.test-user-factory.example.com'); 
		template.username = F45_UTIL_DefaultHelper.ifNullDefault(template.username, testerName + '-user@f45.test-user-factory.example.com'); 
		template.communityNickname = F45_UTIL_DefaultHelper.ifNullDefault(template.communityNickname, testerName+'-community'); 

		SObjectTemplateStrategyInterface strategy = new UserInQuantityStrategy(template, quantity); 
		return (List<User>) F45_FTY_TestSObjectFactory.createTestList(strategy, insertMode); 
	}
	
	public static User create(User template, F45_FTY_RecordInsertMode insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}
	
	public static User create(F45_FTY_RecordInsertMode insertMode){
		return create(new User(), insertMode);
	}

	class UserInQuantityStrategy extends SObjectInQuantityStrategy {
		UserInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'User ', DEFAULT_VALUES_BY_FIELD_MAP);
		}
	}
}