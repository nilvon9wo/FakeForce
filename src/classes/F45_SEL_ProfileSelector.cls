@isTest
public with sharing class F45_SEL_ProfileSelector {
    public List<Profile> selectAll() {
    	return [ 
    		SELECT id, name
    		FROM Profile
    	];
    }
}