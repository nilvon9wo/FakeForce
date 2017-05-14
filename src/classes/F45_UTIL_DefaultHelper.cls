@isTest
public with sharing class F45_UTIL_DefaultHelper {
	public static Object ifNullDefault (Object originalValue, Object defaultValue) {
		return (originalValue == null || String.isEmpty(String.valueOf(originalValue)))
			? defaultValue
			: originalValue;
	}    
	
	public static String ifNullDefault(String originalValue, String defaultValue) {
		return (String) ifNullDefault((Object)originalValue, (Object)defaultValue);
	}
	
	
}