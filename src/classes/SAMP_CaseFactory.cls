@isTest
public class SAMP_CaseFactory extends F45_SObjectFactory { 
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
			'type' => 'Mechanical',
			'status' => 'New',
			'origin' => 'Phone'	
	}; 
	
	public static List<Case> createList(Case template, Integer quantity, F45_DummyInsertMode insertMode){
		MockStrategyInterface strategy = new SessionInQuantityStrategy(template, quantity); 
		return (List<Case>) F45_SObjectFactory.createList(strategy, insertMode); 
	}
	
	public static Case create(Case template, F45_DummyInsertMode insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	} 

	public static Case create(F45_DummyInsertMode insertMode){
		Integer quantity = 1;
		return createList(new Case(), quantity, insertMode)[0];
	}

	class SessionInQuantityStrategy extends SObjectInQuantityStrategy {
		SessionInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Case ', defaultByKeyMap);
		}
	}
	
	public static Case createRealClosingCase(String requestType) {
		Case CaseTemplate = new Case(
			status = 'Closed',   
			vehicle__c = SAMP_VehicleFactory.create(F45_DummyInsertMode.REAL).id, 
			equipment__c = SAMP_ProductFactory.create(F45_DummyInsertMode.REAL).id, 
			type = requestType
		); 
		Case newCase = create(CaseTemplate, F45_DummyInsertMode.REAL);
		Case closedCase = [
			SELECT id, isClosed, vehicle__c, equipment__c, type
			FROM Case
			WHERE id = :newCase.id
		];
		return closedCase; 		 
	}
	
}