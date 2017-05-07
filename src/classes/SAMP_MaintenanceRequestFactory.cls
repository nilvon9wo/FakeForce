@isTest
public class SAMP_MaintenanceRequestFactory extends TEST_SObjectFactory { 
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
			'type' => 'Mechanical',
			'status' => 'New',
			'origin' => 'Phone'	
	}; 
	
	public static List<Case> createList(Case template, Integer quantity, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new SessionInQuantityStrategy(template, quantity); 
		return (List<Case>) TEST_SObjectFactory.createList(strategy, insertMode); 
	}
	
	public static Case create(Case template, TEST_DummyInsertModeEnum insertMode){
		Integer quantity = 1;
		return createList(template, quantity, insertMode)[0];
	}

	public static Case create(TEST_DummyInsertModeEnum insertMode){
		Integer quantity = 1;
		return createList(new Case(), quantity, insertMode)[0];
	}

	class SessionInQuantityStrategy extends SObjectInQuantityStrategy {
		SessionInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Case ', defaultByKeyMap);
		}
	}
	
	public static Case createRealClosingMaintenanceRequest(String requestType) {
		Case maintenanceRequestTemplate = new Case(
			status = 'Closed', 
			vehicle__c = TEST_VehicleFactory.create(TEST_DummyInsertModeEnum.REAL).id, 
			equipment__c = TEST_EquipmentFactory.create(TEST_DummyInsertModeEnum.REAL).id, 
			type = requestType
		);
		Case newMaintenanceRequest = create(maintenanceRequestTemplate, TEST_DummyInsertModeEnum.REAL);
		Case closedMaintenanceRequest = [
			SELECT id, isClosed, vehicle__c, equipment__c, type
			FROM Case
			WHERE id = :newMaintenanceRequest.id
		];
		return closedMaintenanceRequest; 		
	}
	
}