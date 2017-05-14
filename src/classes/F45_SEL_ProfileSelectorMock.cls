@isTest
public with sharing class F45_SEL_ProfileSelectorMock extends F45_SEL_ProfileSelector {
	List<Profile> expectedProfileList;
	
	public F45_SEL_ProfileSelectorMock(List<Profile> expectedProfileList) {
		this.expectedProfileList = expectedProfileList;
	}
	
	public override List<Profile> selectAll() { 
		return this.expectedProfileList;
	} 
}