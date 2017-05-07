@isTest
public class TEST_VehicleFactory extends TEST_SObjectFactory {
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
	}; 
	
	public static List<Vehicle__c> createList(Vehicle__c template, Integer quantity, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new VehicleInQuantityStrategy(template, quantity); 
		return (List<Vehicle__c>) TEST_SObjectFactory.createList(strategy, insertMode); 
	}
	
	public static Vehicle__c create(Vehicle__c template, TEST_DummyInsertModeEnum insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static Vehicle__c create(TEST_DummyInsertModeEnum insertMode){
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