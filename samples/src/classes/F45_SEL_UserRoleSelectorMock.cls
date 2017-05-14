@isTest
public with sharing class F45_SEL_UserRoleSelectorMock extends F45_SEL_UserRoleSelector {
	List<UserRole> expectedUserRoleList;
	
	public F45_SEL_UserRoleSelectorMock(List<UserRole> expectedUserRoleList) {
		this.expectedUserRoleList = expectedUserRoleList;
	}
	
	public override List<UserRole> selectAll() { 
		return this.expectedUserRoleList;
	} 
}