public with sharing virtual class F45_SEL_ProfileSelector {
    public virtual List<Profile> selectAll() {
    	return [ 
    		SELECT id, name
    		FROM Profile
    	];
    }
}