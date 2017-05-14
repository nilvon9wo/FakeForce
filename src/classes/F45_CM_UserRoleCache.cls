@isTest
public with sharing class F45_CM_UserRoleCache {
    private static Map<String, UserRole> userRoleByNameMap;
    
    public static UserRole getByName(String name){
    	if (userRoleByNameMap == null) {
    		userRoleByNameMap = loaduserRoleByNameMap();
    	}
    	return userRoleByNameMap.get(name);
    }
    
    private static Map<String, UserRole> loaduserRoleByNameMap() {
    	List<UserRole> userRoleList = (new F45_SEL_UserRoleSelector()).selectAll();
    	userRoleByNameMap = new Map<String, UserRole>();
    	for (UserRole UserRole : userRoleList) {
    		userRoleByNameMap.put(UserRole.name, UserRole);
    	}
    	return userRoleByNameMap;
    }
}