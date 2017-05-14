@isTest
public with sharing class F45_SEL_UserRoleSelector {
    public List<UserRole> selectAll() {
    	return [ 
    		SELECT id, name
    		FROM UserRole
    	];
    }
}