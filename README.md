# FakeForce
A library of utility classes for creating Apex unit and integration tests.

Includes some sample documentation and sample metadata to illustrate use.

## Anticipated Questions:

### About FakeForce:
#### Why do I need factories to create my SObject test data?
"Need" is a relative term.
It is absolutely true that you can live without them.

However, let's imagine you have 300 tests each creating their own data for Case.
The project has just been updated to meet a requirement where Case is now a required field.
Now you have the fun task of manually updating each of those 300 tests.
And by the time you finish, the clients had just decided "Oh yes, SLA Violation is required too".

Now, rather than living and reliving variations of that nightmare, you can have a utility class which is responsible for
creating each instead of test data.

#### Why use the FakeForce SObject Factory (F45_SObjectFactory), instead of just creating my own factories?
F45_SObjectFactory creates a standardized way of manufacturing data, ensuring that your test data factories have consistent interfaces
and you don't need to reimplement logic for transcribing data from your templates and deciding whether to insert.

#### Which files do I need if I want to use this in a real project?
The only files you will need for a real project are the src/classes with the *F45_* prefix.

#### What do the file prefixes mean:
* F45 - FakeForce
* SAMP - Sample

#### Why F45?
Because I like bad puns.

#### How can I learn more about this project?
Read the source code.
Also -- just for you -- I've included some useful commentary in the otherwise clean source code.

### About Testing:
### Do you have any solution for creating Behavior Driven Development tests in Salesforce.com 
See https://github.com/nilvon9wo/zucchini
