public class SDAO_ProductSelector {
    public List<Product2> selectById(Set<Id> idSet) {
    	return [
    		SELECT id, maintenance_cycle__c 
    		FROM Product2
    		WHERE id IN :idSet
    	]; 
    }
}