public virtual class SDAO_ProductDml {
	public virtual Database.UpsertResult[] doUpsertUsingSkuAsExternalKey(List<Product2> updatedProductList){
		Schema.SObjectField externalKey = Product2.fields.warehouse_sku__c;
		return Database.upsert(updatedProductList, externalKey, false);  
	}    
}