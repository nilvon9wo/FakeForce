@isTest 
public class SDAO_ProductDmlMock extends SDAO_ProductDml { 
	public List<Product2> updatedEquipmentList {private set; get;}
	
	public override Database.UpsertResult[] doUpsertUsingSkuAsExternalKey(List<Product2> updatedEquipmentList){
    	if (updatedEquipmentList != null && !updatedEquipmentList.isEmpty()) {
    		this.updatedEquipmentList = updatedEquipmentList;
    	}
    	return null;
    }
}