@isTest
public class SAMP_EquipmentFactory extends F45_SObjectFactory {
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
		'replacement_part__c' => true
	}; 
	
	public static List<Product2> createList(Product2 template, Integer quantity, F45_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new EquipmentInQuantityStrategy(template, quantity); 
		return (List<Product2>) F45_SObjectFactory.createList(strategy, insertMode); 
	}
	
	public static Product2 create(Product2 template, F45_DummyInsertModeEnum insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static Product2 create(F45_DummyInsertModeEnum insertMode){
		Product2 template = new Product2();
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	class EquipmentInQuantityStrategy extends SObjectInQuantityStrategy {
		EquipmentInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Equipment ', defaultByKeyMap);
		}
	}
	
	public static List<Product2> createList(List<Product2> templateList, F45_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new EquipmentPerTemplateStrategy(templateList); 
		return (List<Product2>) F45_SObjectFactory.createList(strategy, insertMode); 
	}
	
	class EquipmentPerTemplateStrategy extends SObjectPerTemplateStrategy {
		EquipmentPerTemplateStrategy(List<SObject> templateList) {
			super(templateList, 'Equipment ', defaultByKeyMap);
		}
	}
}