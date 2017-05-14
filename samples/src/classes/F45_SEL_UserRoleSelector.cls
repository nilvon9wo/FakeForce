public with sharing virtual class F45_SEL_UserRoleSelector {
    public virtual List<UserRole> selectAll() {
    	return [ 
    		SELECT id, name
    		FROM UserRole
    	];
    }
}