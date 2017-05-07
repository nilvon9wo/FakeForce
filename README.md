# FakeForce
A library of utility classes for creating Apex unit and integration tests.

Includes some sample documentation and sample metadata to illustrate use.

## Anticipated Questions:

### Why do I need factories to create my SObject test data?
"Need" is a relative term.
It is absolutely true that you can live without them.

However, let's imagine you have 300 tests each creating their own data for Case.
The project has just been updated to meet a requirement where Case is now a required field.
Now you have the fun task of manually updating each of those 300 tests.
And by the time you finish, the clients had just decided "Oh yes, SLA Violation is required too".

Now, rather than living and reliving variations of that nightmare, you can have a utility class which is responsible for
creating each instead of test data.

### Why use the FakeForce SObject Factory (F45_SObjectFactory), instead of just creating my own factories?
F45_SObjectFactory creates a standardized way of manufacturing data, ensuring that your test data factories have consistent interfaces
and you don't need to reimplement logic for transcribing data from your templates and deciding whether to insert.

### What is Dependency Injection and why is it important for testing? 
Let me get back to you on that, but till then, you can read https://en.wikipedia.org/wiki/Dependency_injection

### What are Data Access Objects (DAO) and why are they important for unit testing?
Let me get back to you on that, but till then, you can read https://en.wikipedia.org/wiki/Data_access_object

### How should I deal with Http and WebService Callouts?
To begin with, I recommend wrapping the callouts to a service which you inject, so you can then simply mock it out like DAO or anything else.
But you'll want to create integration tests for the callout service.
For that, I have no special techniques.  SFDC's native functionality serves well enough.

### Why do some class files have the suffix IntTest instead of just Test?
This is a convention to indicate these are integration tests (i.e., they touch the database).
It can be useful to know this because they will take longer to execute.

### Which files do I need if I want to use this in a real project?
The only files you will need for a real project are the src/classes with the *F45_* prefix.

### What do the class prefixes mean:
* F45 - FakeForce
* SPRD - Sample production code other than DAO
* SDAO - Sample database access objects
* SF45 - Code which leverages FakeForce (i.e., the tests, the mocks, and the fake data factories)

### On a real project, would you use the above prefix strategy to divide your code this way?
Not exactly.  The above division is intended to make it easier to see where and how the FakeForce library is being used.

On a real project (unless the project has requirements to the contrary), 
I would keep code together according to feature, with the following exceptions:

* DB - for all database access objects
* TRG - for all trigger handlers

I make these exceptions because I'd prefer for all the code, regardless of origin or purpose 
to use common trigger handlers and database object access handlers to avoid race conditions and ensure
when data is passed between classes, it carries all the required properties.

I however, seek to standardize suffixs, such that given a feature, object, or sObject foo, the following classnames might be used:

* DB_FooSelector
* DB_FooSelectorIntTest			- Integration tests of FooSelector
* DB_FooSelectorTest			- Unit tests of FooSelector
* DB_FooSelectorMock    		- Extends FooSelector, allowing it to injected in place of FooSelector for testing other classes 
* DB_FooDml
* DB_FooDmlIntTest				- Integration tests of FooSelector
* DB_FooDmlTest					- Unit tests of FooSelector
* DB_FooDmlMock    				- Extends FooSelector, allowing it to injected in place of FooSelector for testing other classes 
* TRG_FooTriggerHandler
* TRG_FooTriggerHandlerTest		- Unit tests of FooTriggerHandler
* TRG_FooTriggerHandlerIntTest	- Integration tests of FooTriggerHandler
* TRG_FooTriggerHandlerMock		- Extends FooTriggerHandler, allowing it to injected in place of FooTriggerHandler for testing other classes 

For brevity, I won't continue to list Test, IntTest, and Mock below, and assuming PRJ_ is the prefix assigned to the project:

* PRJ_FooService 
* PRJ_FooAuraCtrl	- For controlling Foo Aura/Lightning, (but SFDC calls everything Lightning making it meaningless).
* PRJ_FooVFPageCtrl	- For controlling Foo VisualForce page
* PRJ_FooVFCmpCtrl	- For controlling Foo VisualForce component
* PRJ_FooRestCtrl	- For providing RESTful services of Foo 

### Why F45?
Because I like bad puns.  (I'll let you think about that for awhile.)

### Why isn't all the sample code completely functional?
The point of the sample code isn't to provide complete functionality, but to demonstrate how things can be done.
Also, I neither wanted to include fflib as a dependency or refactor all the code which previously depended upon it.

### How do you think about Apex Mocks?  Can I combine these projects?
Financial Force is brilliant.  I particulary appreciate their work on Apex Enterprise Patterns, particularly for
the trigger handlers and selectors.  Among the stripped out code was references to their work, not because I didn't like
it but because I didn't want to make their work a dependency for this project.

Also, I really like the idea of bringing Mockito to SFDC.
That said, Apex Mocks has too much overhead and is too complicated.
Or I haven't seen any good examples of its use.
 
It is completely possible to create mocks and use dependency without it, as you'll find within the sample code.
However, if you find it useful, don't allow me to discourage you from doing so.
And please let me know if you find any interesting ways to combine these two projects.

### How can I learn more about this project?
Read the source code.
Also -- just for you -- I've included some useful commentary in the otherwise clean source code.

### Do you have any solution for creating Behavior Driven Development tests in Salesforce.com 
See https://github.com/nilvon9wo/zucchini

## Further Resources 
### Testing
	* Test Pyramid, https://martinfowler.com/bliki/TestPyramid.html
	* Unit Testing, http://searchsoftwarequality.techtarget.com/definition/unit-testing
	* Integration Testing, https://msdn.microsoft.com/en-us/library/aa292128(v=vs.71).aspx
	* Acceptance Testing, https://www.agilealliance.org/glossary/acceptance/
	* Just Say No to More End-to-End Tests, https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html
	* Software Testing, https://en.wikipedia.org/wiki/Software_testing

### Salesforce.com Native Mock Callouts
	* Test Web Service Callouts, https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_callouts_wsdl2apex_testing.htm 
	* Testing HTTP Callouts by Implementing the HttpCalloutMock Interface, https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_restful_http_testing_httpcalloutmock.htm
		
### FinancialForce
	* FinancialForce Apex Mocks, https://github.com/financialforcedev/fflib-apex-mocks
	* FinancialForce Apex Common, https://github.com/financialforcedev/fflib-apex-common
