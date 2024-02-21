/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CreateContactTest {
    
    @testSetup static void dataCollection(){
        Date startDate = Date.parse('01/01/2019');
        Date endDate = startDate.addYears(1);
        List<Account> accountList = new List<Account>();
        Account account1 = new Account(Name='Testing', Start_Date__c=startDate, End_Date__c=endDate);
        accountList.add(account1);
    } 
    

    @isTest
    static void contactCreateOnInsert() {
        List<Account> accountList = new List<Account>();
        Account account1 = new Account(Name='Testing', Start_Date__c=Date.parse('01/01/2019'), End_Date__c=Date.parse('01/01/2020'));
        accountList.add(account1);
        
        Test.startTest();
        CreateContact conCreate = new CreateContact();
        conCreate.contactCreateOnInsert(accountList);
        List<Contact> contactList = [SELECT ID from Contact WHERE AccountID =: accountList[0].Id];
        System.assertEquals(accountList[0].Start_Date__c.monthsBetween(accountList[0].End_Date__c)+1,contactList.size());
        Test.stopTest();
    }
    
    @isTest
    static void contactCreateOnUpdate() {
        List<Account> accountListWithData = new List<Account>();
        Account account1 = new Account(Name='Testing', Start_Date__c=Date.parse('01/01/2019'), End_Date__c=Date.parse('01/01/2020'));
        accountListWithData.add(account1);
        
        Account account = new Account(Id=accountListWithData[0].Id, Start_Date__c =null, End_Date__c=null);
        Map<Id, Account> accountOldMap = new Map<Id, Account>{account.Id => account};
        Test.startTest();
        CreateContact conCreate = new CreateContact();
        conCreate.contactCreateOnUpdate(accountListWithData, accountOldMap);
        List<Contact> contactList = [SELECT ID from Contact WHERE AccountID =: accountListWithData[0].Id];
        System.assertEquals(accountListWithData[0].Start_Date__c.monthsBetween(accountListWithData[0].End_Date__c)+1,contactList.size());
        Test.stopTest();
    }
}