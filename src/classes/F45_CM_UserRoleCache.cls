@isTest
public with sharing class F45_CM_UserRoleCache {
    private static Map<String, UserRole> userRoleByNameMap;

	F45_SEL_UserRoleSelector selector;
	
	public F45_CM_UserRoleCache(F45_SEL_UserRoleSelector selector) {
		this.selector = selector;
	}
	
	public F45_CM_UserRoleCache() {
		this.selector = new F45_SEL_UserRoleSelector();
	}
    
    public UserRole getByName(String name){
    	if (userRoleByNameMap == null || userRoleByNameMap.get(name) == null) {
    		userRoleByNameMap = buildUserRoleByNameMap();
    	}
    	return userRoleByNameMap.get(name);
    }
    
    @testVisible
    private Map<String, UserRole> buildUserRoleByNameMap() {
    	List<UserRole> userRoleList = this.selector.selectAll();
    	userRoleByNameMap = new Map<String, UserRole>();
    	for (UserRole UserRole : userRoleList) {
    		userRoleByNameMap.put(UserRole.name, UserRole);
    	}
    	return userRoleByNameMap;
    }
}