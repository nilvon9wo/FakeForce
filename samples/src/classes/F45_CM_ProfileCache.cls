@isTest
public with sharing class F45_CM_ProfileCache {
    private static Map<String, Profile> profileByNameMap;

	F45_SEL_ProfileSelector selector;
	
	public F45_CM_ProfileCache(F45_SEL_ProfileSelector selector) {
		this.selector = selector;
	}
	
	public F45_CM_ProfileCache() {
		this.selector = new F45_SEL_ProfileSelector();
	}
    
    public Profile getByName(String name){
    	if (profileByNameMap == null || profileByNameMap.get(name) == null) {
    		profileByNameMap = buildProfileByNameMap();
    	}
    	return profileByNameMap.get(name);
    }
    
    @testVisible
    private Map<String, Profile> buildProfileByNameMap() {
    	List<Profile> profileList = this.selector.selectAll(); 
    	profileByNameMap = new Map<String, Profile>();
    	for (Profile profile : profileList) {
    		profileByNameMap.put(profile.name, profile);
    	}
    	return profileByNameMap;
    }
}