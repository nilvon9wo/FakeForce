public virtual class DB_EquipmentDml {
	public virtual Database.UpsertResult[] doUpsertUsingSkuAsExternalKey(List<Product2> updatedEquipmentList){
		Schema.SObjectField externalKey = Product2.fields.warehouse_sku__c;
		return Database.upsert(updatedEquipmentList, externalKey, false);
	}    
}