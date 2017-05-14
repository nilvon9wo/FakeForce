@isTest
public with sharing class F45_CM_ProfileCache {
    private static Map<String, Profile> profileByNameMap;
    
    public static Profile getByName(String name){
    	if (profileByNameMap == null) {
    		profileByNameMap = loadProfileByNameMap();
    	}
    	return profileByNameMap.get(name);
    }
    
    private static Map<String, Profile> loadProfileByNameMap() {
    	List<Profile> profileList = (new F45_SEL_ProfileSelector()).selectAll(); 
    	profileByNameMap = new Map<String, Profile>();
    	for (Profile profile : profileList) {
    		profileByNameMap.put(profile.name, profile);
    	}
    	return profileByNameMap;
    }
}