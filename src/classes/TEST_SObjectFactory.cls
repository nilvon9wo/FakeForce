public virtual class TEST_SObjectFactory {
	public static List<SObject> createList (MockStrategyInterface mockStrategy, TEST_DummyInsertModeEnum insertMode) {
		List<SObject> mockSObjectList = new List<SObject>();
		mockStrategy.execute(mockSObjectList);  
		TEST_DMLHelper.doInsert(mockSObjectList, insertMode);
		return mockSObjectList;
	}
	
	public interface MockStrategyInterface {
		List<SObject> execute(List<SObject> mockSObjectList);
	} 

	// ----------------------------------------------------------------------------------------
	
	public virtual class SObjectInQuantityStrategy implements MockStrategyInterface {
		protected SObject template;
		protected Integer quantity;
		protected String defaultName; 
		protected Map<String, Object> defaultByKeyMap; 

		private Map<SObjectType, String> nameFieldOverrideMap = new Map<SObjectType, String>{
			Case.getSObjectType() => 'subject',
			Contact.getSObjectType() => 'lastName',
			Lead.getSObjectType() => 'lastName'
			
			// NOTE: If you want to use this Factory with an SObject which does not contain any Text field,
			//		 You will need to add one. 
			// Work_Part__c.getSObjectType() => 'TEST_DEBUG__c'
		}; 
		
		public SObjectInQuantityStrategy(SObject template, Integer quantity, String defaultName, Map<String, Object> defaultByKeyMap){
			this.template = template;
			this.quantity = quantity;
			this.defaultName = defaultName;
			this.defaultByKeyMap = defaultByKeyMap;
		}
		
		public SObjectInQuantityStrategy(SObject template, Integer quantity, String defaultName){
			this(template, quantity, defaultName, new Map<String, Object>());
		}
		 
		public SObjectInQuantityStrategy(SObject template, Integer quantity){
			this(template, quantity, 'SObject', new Map<String, Object>());
		}
		  
		public virtual List<SObject> execute(List<SObject> mockSObjectList) {
			for (Integer i = 1; i <= this.quantity; i++) {
				this.fillName(template, i);
				for (String key : this.defaultByKeyMap.keySet()) {
					fillIfBlank (template, key, this.defaultByKeyMap.get(key));
				}
				mockSObjectList.add(template.clone());
			}
			return mockSObjectList; 
		}
		
		private String fillName(SObject template, Integer index) {
				SObjectType sObjType = template.getSObjectType();
				String overrideNameField = nameFieldOverrideMap.get(sObjType);
				String nameField = (!String.isBlank(overrideNameField)) ? overrideNameField : 'name';
				fillIfBlank (template, nameField, this.defaultName + index);
				return nameField;
		}
	}

	// ----------------------------------------------------------------------------------------------
	
	public virtual class nSObjectPerRelatedSObjectStrategy extends SObjectInQuantityStrategy {
		String relatedField;
		List<SObject> sObjectList;
		
		public nSObjectPerRelatedSObjectStrategy(
			SObject template, 
			Integer quantity, 
			String defaultName, 
			String relatedField,
			List<SObject> sObjectList,
			Map<String, Object> defaultByKeyMap
		){
			super(template, quantity, defaultName, new Map<String, Object>());
			this.relatedField = relatedField;
			this.sObjectList = sObjectList;
		}
		 
		public nSObjectPerRelatedSObjectStrategy(
			SObject template, 
			Integer quantity, 
			String defaultName,
			String relatedField,
			List<SObject> sObjectList 
		){
			this(template, quantity, defaultName, relatedField, sObjectList, new Map<String, Object>());
		}
		
		public override List<SObject> execute(List<SObject> mockSObjectList) {
			for (SObject obj : SObjectList) {
				this.defaultByKeyMap.put(this.relatedField, obj.get('id'));
				super.execute(mockSObjectList);
			}
			return mockSObjectList; 
		}
	}

	// ----------------------------------------------------------------------------------------
	
	public virtual class SObjectPerTemplateStrategy implements MockStrategyInterface {
		protected List<SObject> templateList;
		protected String defaultName; 
		protected Map<String, Object> defaultByKeyMap; 

		private Map<SObjectType, String> nameFieldOverrideMap = new Map<SObjectType, String>{
			Case.getSObjectType() => 'subject',
			Contact.getSObjectType() => 'lastName',
			Lead.getSObjectType() => 'lastName'
			
			// NOTE: If you want to use this Factory with an SObject which does not contain any Text field,
			//		 You will need to add one. 
			// Work_Part__c.getSObjectType() => 'TEST_DEBUG__c' 
		}; 
		
		public SObjectPerTemplateStrategy(List<SObject> templateList, String defaultName, Map<String, Object> defaultByKeyMap){
			this.templateList = templateList;
			this.defaultName = defaultName;
			this.defaultByKeyMap = defaultByKeyMap;
		}
		
		public SObjectPerTemplateStrategy(List<SObject> templateList, String defaultName){
			this(templateList, defaultName, new Map<String, Object>());
		}
		  
		public SObjectPerTemplateStrategy(List<SObject> templateList){
			this(templateList, 'SObject', new Map<String, Object>());
		}
		  
		public virtual List<SObject> execute(List<SObject> mockSObjectList) {
			Integer i = 0;
			for (SObject template :  templateList) {
				this.fillName(template, i++);
				for (String key : this.defaultByKeyMap.keySet()) {
					fillIfBlank (template, key, this.defaultByKeyMap.get(key));
				}
				mockSObjectList.add(template.clone());
			}
			return mockSObjectList; 
		}
		
		private String fillName(SObject template, Integer index) {
				SObjectType sObjType = template.getSObjectType();
				String overrideNameField = nameFieldOverrideMap.get(sObjType);
				String nameField = (!String.isBlank(overrideNameField)) ? overrideNameField : 'name';
				fillIfBlank (template, nameField, this.defaultName + index);
				return nameField;
		}
	}
     	
	// ----------------------------------------------------------------------------------------------
	
	public static SObject fillIfBlank (SObject sObj, String targetField, Object fillValue) {
		Object value = sObj.get(targetField);
		if (String.isBlank(String.valueOf(value))) { 
			sObj.put(targetField, fillValue); 
		}
		return sObj ;
	}
}