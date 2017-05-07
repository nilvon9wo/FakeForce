@isTest 
public class TEST_RunAsUserFactory {
    public static User create(String testerName, String testerProfileString, String testerRoleString){
        // cf. http://stackoverflow.com/questions/2387475/how-to-avoid-mixed-dml-operation-error-in-salesforce-tests-that-create-users
        // cf. http://www.verious.com/qa/how-to-avoid-mixed-dml-operation-error-in-salesforce-tests-that-create-users/

        // Assumption: First user created will still be an admin when test is run.  If this assumption is wrong, some tests may fail.       
        User firstUser = [ SELECT id FROM User ORDER BY CreatedDate LIMIT 1 ];
        System.runAs ( firstUser ) {
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
        return firstUser;
    }

    public static User create(){
            Integer unique = (Integer) (Math.random() * 999999);
            String testerName = 'Testuser' + unique;
            return create(testerName, 'System Administrator', 'CEO');
    }
}