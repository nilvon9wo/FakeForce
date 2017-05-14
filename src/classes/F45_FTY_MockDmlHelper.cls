/**
 *  Anticipated Questions and anwsers
 *
 *	Q: Is there a timeline to add support for before and after trigger mocking.
 *
 *	A: No, but to be honest I never wrote a unit test which I felt really needed this.
 *		If you need this, you probably need an integration test.
 *		If you need an integration test, you probably shouldn't be using mock DML.
 *
 *	Q: Is there any plan to implement mockUpdate, mockDelete, or mockUndelete.
 *
 *	A: I've never needed any of these, so probably not.
 *
 *	Of course, if you implement any of this, feel free to send me a pull request. :-)
 **/
@isTest
public class F45_FTY_MockDmlHelper 
{
    private static Integer mockIdCounter = 1;

    public static void mockInsert (List<SObject> dummySObjectList)
    {   
        for (SObject dummySObject : dummySObjectList)
        {                           
            // TODO: Add support for before trigger mocking.
            
            String  mockIdString   = '00000000000' + mockIdCounter++;   // We increment the mockIdCounter so each dummy SObject gets a unique identifier.
            Integer subStringStart = (mockIdString.length() > 12) ? (mockIdString.length() - 12) : 0; 
            dummySObject.put('id', (Id) (F45_FTY_SObjectPrefixHelper.get(dummySObject.getSObjectType()) + mockIdString.subString(subStringStart))); 

            // TODO: Add support for after trigger mocking.  

        }  
    } 

    public static void mockInsert (SObject dummySObject) { mockInsert (new List<SObject> { dummySObject }); }
 
}