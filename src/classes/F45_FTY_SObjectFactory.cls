/**
 *  Anticipated Questions and anwsers
 * 	Q: Why do I need factories to create my SObject test data?
 *
 * 	A: "Need" is a relative term.
 * 		It is absolutely true that you can live without them.
 *
 * 		However, let's imagine you have 300 tests each creating their own data for Case.
 *		The project has just been updated to meet a requirement where Case is now a required field.
 * 		Now you have the fun task of manually updating each of those 300 tests.
 * 		And by the time you finish, the clients had just decided "Oh yes, SLA Violation is required too".
 *
 * 		Now, rather than living and reliving variations of that nightmare, you can have a utility class which is responsible for
 *		creating each instead of test data.
 *
 * 	Q: Why use the FakeForce SObject Factory (F45_FTY_SObjectFactory), instead of just creating my own factories?
 *
 * 	A: F45_FTY_SObjectFactory creates a standardized way of manufacturing data, ensuring that your test data factories have consistent interfaces
 * 		and you don't need to reimplement logic for transcribing data from your templates and deciding whether to insert.
 *
 * 	Q: What is the point of the SObject templates which can be passed into your creation methods?
 *		Why not create all the data within the factory?
 *
 *	A: If you are writing good test -- and I hope you are -- your test will need to control and make predictions about
 *		What data will be in the object.  If the data were created within the factory, the factory would be less flexible and/or
 *		your tests would be less readable.
 *
 *		So, instead, you create an SObject with the values you care about (for example, an Account's name) and the factory will take
 *		of filling in required fields and (if necessary) provide an SFID (either real or fake).
 *
 *  Q: How can I use the F45_FTY_SObjectFactory to fake data for SObjects without a name fields? 
 *     	(And why is this a problem anyway?)
 *
 *  A: In order to facilitate debugging, the included F45_FTY_SObjectFactory mocking strategies will gives each SObject instance a unique text value.  
 *		By default, it stores this value in the "Name" property, which causes an error if that property does not exist.
 *     	In order to fix this, you have two possibilites:
 *
 *      1. (Recommended) Add the sObjectType and an alternative target to the nameFieldOverrideMap for the desired strategy.
 *
 *      2. Create your own Mock Strategy Implementation
 *      	If you create something useful, please send a pull request.  :-)  
 *
 *  Q: How can I use the F45_FTY_SObjectFactory to fake data for SObjects without any text fields?
 *  
 *  A: In order to fix this, you have three possibilites:
 *  	1. (Recommended) Add a text field to the SObject.  You can keep this hidden from real users.
 *
 *  	2. Create your own Mock Strategy Implementation
 * 	   		If you create something useful, please send a pull request.  :-)
 *	
 *  	3. (Not recommended) Refactor F45_FTY_SObjectFactory so such a field is no longer required.
 *	   		If you feel your modification is really worth sharing feel free to explain why and send a pull request.  
 * 
 *  Q: Why isn't the SF45_WorkPartFactory class working as expected?
 *  
 *  A: This sample was created as an instance of an SObject without a text field.
 *     	It is also the only custom SObject referenced by the F45_* files.
 *	    In order to keep deployment of the F45_ files easy, I've commented out the map entries which will enable it to work.
 * 
 *      To fix the class, just uncomment the map entries.  
 *      (As this is an unmanaged package, there is little you shouldn't do that, unless your concerned about updatees...) 
 *
 *  Q: How can I safely modify the nameFieldOverrideMap so revisions won't be lost if I update this package?
 *
 *  A: As the nameFieldOverrideMap is a public property, you can put values into it when you arrange your tests.
 *
 *  Q: Does F45_FTY_SObjectFactory need coverage?  If so, why?
 *
 *  A: Salesforce.com does not allow developers to annotate virtual classes with @isTest.
 * 		F45_FTY_SObjectFactory needs to be a virtual class so it can be extended by concrete data factories, such as SF45_ProductFactory.
 *
 *		If you use all the strategies in F45_FTY_SObjectFactory, the class will be covered 100%.
 *		If you do not use all the strategies, you can safely delete those which you don't use. 
 *
 *	Q: Why haven't you included tests for the F45_FTY_SObjectFactory?
 * 
 *	A: When I created the Factory, the tests which depended upon it were sufficent to prove its viability, as well as provide 100% coverage.
 *		If you feel they are desirable, feel free to create them and send a pull request. :-)
 **/
//@isTest -- But SFDC does not allow this annotation on virtual classes
public virtual class F45_FTY_SObjectFactory {
	F45_FTY_DmlHelperIntf dmlHelper;
	
	public F45_FTY_SObjectFactory(F45_FTY_DmlHelperIntf dmlHelper){
		this.dmlHelper = dmlHelper;
	}
	
	public F45_FTY_SObjectFactory(){
		this(new F45_FTY_DmlForProductionHelper());
	}
	
	public List<SObject> createList (SObjectTemplateStrategyInterface templateStrategy, F45_FTY_RecordInsertMode insertMode) {
		List<SObject> sObjectList = new List<SObject>();
		templateStrategy.execute(sObjectList);  
		this.dmlHelper.doInsert(sObjectList, insertMode); 
		return sObjectList;
	}
	 
	public interface SObjectTemplateStrategyInterface {
		List<SObject> execute(List<SObject> mockSObjectList);
	} 

	public static Map<SObjectType, String> nameFieldOverrideMap = new Map<SObjectType, String>{
		Case.getSObjectType() => 'subject',
		Contact.getSObjectType() => 'lastName',
		Lead.getSObjectType() => 'lastName'
		
		// NOTE: If you want to use this Factory with an SObject which does not contain any Text field,
		//		 You will need to add one. 
		// Work_Part__c.getSObjectType() => 'F45_DEBUG__c'
	}; 

	// ----------------------------------------------------------------------------------------
	
	public virtual class SObjectInQuantityStrategy implements SObjectTemplateStrategyInterface {
		protected SObject template;
		protected Integer quantity;
		protected String defaultName; 
		protected Map<String, Object> defaultByKeyMap; 

		
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
	
	public virtual class SObjectPerTemplateStrategy implements SObjectTemplateStrategyInterface {
		protected List<SObject> templateList;
		protected String defaultName; 
		protected Map<String, Object> defaultByKeyMap; 

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