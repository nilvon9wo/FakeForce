@isTest
public class SAMP_VehicleFactory extends F45_SObjectFactory {
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
	}; 
	
	public static List<Vehicle__c> createList(Vehicle__c template, Integer quantity, F45_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new VehicleInQuantityStrategy(template, quantity); 
		return (List<Vehicle__c>) F45_SObjectFactory.createList(strategy, insertMode); 
	}
	
	public static Vehicle__c create(Vehicle__c template, F45_DummyInsertModeEnum insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static Vehicle__c create(F45_DummyInsertModeEnum insertMode){
		Vehicle__c template = new Vehicle__c(); 
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	class VehicleInQuantityStrategy extends SObjectInQuantityStrategy {
		VehicleInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Vehicle__c ', defaultByKeyMap);
		}
	}
}