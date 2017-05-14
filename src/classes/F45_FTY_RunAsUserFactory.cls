/**
 *  Anticipated Questions and anwsers
 *
 *  Q: Why should I use F45_FTY_RunAsUserFactory?
 *	A: For your tests to be stable -- that is to say, provide the same result, regardless of execution context -- 
 *		your tests must define the user which is executing any particular code you wish to test.
 *		Otherwise, SFDC make questionable assumptions and your results can vary.  
 *
 *	Q: Why didn't you use the F45_FTY_SObjectFactory to create your test user?
 *	A: Because this was a solved problem which I've felt no need or desire to refactor
 *
 *  Q: Doesn't the overhead of creating the User make every test which uses one an integration test?
 *	A: Technically yes, but I find stable tests to be more important then ideals.
 *
 *  Q: Why do you need to create a User to create another User?
 *  A: There is no really good explanation (to my mind), but this is best known work around for an old issue: 	
 *  	See: http://stackoverflow.com/questions/2387475/how-to-avoid-mixed-dml-operation-error-in-salesforce-tests-that-create-users
 *
 *  Q: Do you ever create users who aren't System Administrators?
 *  A: Rarely, and mostly for integration tests.
 **/
@isTest 
public class F45_FTY_RunAsUserFactory {
    public static User create(String testerName, String testerProfileString, String testerRoleString){
        User originalAdmin = [ SELECT id FROM User WHERE profile.name = 'System Administrator' ORDER BY CreatedDate LIMIT 1 ];
        System.runAs ( originalAdmin ) {
            Profile  testUserProfile = [SELECT id FROM Profile  WHERE Name = :testerProfileString LIMIT 1];
            UserRole testUserRole    = [SELECT id FROM UserRole WHERE Name = :testerRoleString    LIMIT 1];
            
            User testRunUser                   = new User();
                 testRunUser.LastName          = testerName;
                 testRunUser.Alias             = testerName.left(1)+testerName.right(7);
                 testRunUser.Email             = testerName + '@runas.example.com';
                 testRunUser.Username          = testerName + '@runas.example.com';
                 testRunUser.CommunityNickname = testerName;
                 testRunUser.ProfileId         = testUserProfile.id;
                 testRunUser.UserRoleId        = testUserRole.id;
                 testRunUser.LanguageLocaleKey = 'en_US';
                 testRunUser.LocaleSidKey      = 'en_US';
                 testRunUser.EmailEncodingKey  = 'UTF-8';
                 testRunUser.TimeZoneSidKey    = 'Europe/Berlin';
                 
            insert testRunUser;
            return testRunUser;
        }
        return originalAdmin;
    }

    public static User create(){
            Integer unique = (Integer) (Math.random() * 999999);
            String testerName = 'Testuser' + unique;
            return create(testerName, 'System Administrator', 'CEO');
    }
}