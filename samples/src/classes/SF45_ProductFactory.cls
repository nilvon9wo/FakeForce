@isTest 
public class SF45_ProductFactory extends F45_FTY_SObjectFactory {
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
		'replacement_part__c' => true
	};  
	
	public static List<Product2> createList(Product2 template, Integer quantity, F45_FTY_RecordInsertMode insertMode){
		SObjectTemplateStrategyInterface strategy = new ProductInQuantityStrategy(template, quantity); 
		return (List<Product2>) F45_FTY_TestSObjectFactory.createTestList(strategy, insertMode); 
	}
	
	public static Product2 create(Product2 template, F45_FTY_RecordInsertMode insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static Product2 create(F45_FTY_RecordInsertMode insertMode){
		Product2 template = new Product2();
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	class ProductInQuantityStrategy extends SObjectInQuantityStrategy {
		ProductInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Product ', defaultByKeyMap);
		}
	}
	
	public static List<Product2> createList(List<Product2> templateList, F45_FTY_RecordInsertMode insertMode){
		SObjectTemplateStrategyInterface strategy = new ProductPerTemplateStrategy(templateList); 
		return (List<Product2>) F45_FTY_TestSObjectFactory.createTestList(strategy, insertMode); 
	}
	
	class ProductPerTemplateStrategy extends SObjectPerTemplateStrategy {
		ProductPerTemplateStrategy(List<SObject> templateList) {
			super(templateList, 'Product ', defaultByKeyMap);
		}
	}
}