@isTest 
public class F45_FTY_SObjectPrefixHelper {
	public static String get(Schema.SObjectType sObjectType) {
		return sObjectType.getDescribe().getKeyPrefix();
	}
}