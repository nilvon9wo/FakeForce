@isTest
public class TEST_MockDMLHelper 
{
    private static Integer mockIdCounter = 1;

    public static void mockInsert (List<SObject> dummySObjectList)
    {   
        for (SObject dummySObject : dummySObjectList)
        {                           
            // TODO: Add support for before trigger mocking.
            
            String  mockIdString   = '00000000000' + mockIdCounter++;   // We increment the mockIdCounter so each dummy SObject gets a unique identifier.
            Integer subStringStart = (mockIdString.length() > 12) ? (mockIdString.length() - 12) : 0; 
            dummySObject.put('id', (Id) (TEST_SObjectPrefixHelper.get(dummySObject.getSObjectType()) + mockIdString.subString(subStringStart))); 

            // TODO: Add support for after trigger mocking.  

        }  
    } 

    public static void mockInsert (SObject dummySObject) { mockInsert (new List<SObject> { dummySObject }); }
 
}