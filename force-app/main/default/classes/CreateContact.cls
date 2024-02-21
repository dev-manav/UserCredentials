public class CreateContact {
    public void contactCreateOnInsert(List<Account> accountList){
        List<Contact> contactList = new List<Contact>();
        for(Account account: accountList){
            if(account.Start_Date__c != null && account.End_Date__c != null){
                Integer contactNumber = account.Start_Date__c.monthsBetween(account.End_Date__c);
                for(Integer i=0; i<=contactNumber; i++){
                    Datetime newDate = Datetime.newInstance(account.Start_Date__c.Year(), account.Start_Date__c.Month()+i, account.Start_Date__c.Day());
                    Contact newContact = new Contact(LastName=newDate.format('MMM')+' '+String.valueOf(newDate.year()), AccountId = account.Id);
                    contactList.add(newContact);
                }
            }
        }
        insert contactList;
    }

    public void contactCreateOnUpdate(List<Account> newAccountList, Map<Id, Account> oldAccountMap){
        List<Contact> contactList = new List<Contact>();
        for(Account account: newAccountList){
            if(oldAccountMap.get(account.Id).Start_Date__c == null || oldAccountMap.get(account.Id).End_Date__c == null){
                if(account.Start_Date__c != null && account.End_Date__c != null){
                    Integer contactNumber = account.Start_Date__c.monthsBetween(account.End_Date__c);
                    for(Integer i=0; i<=contactNumber; i++){
                        Datetime newDate = Datetime.newInstance(account.Start_Date__c.Year(), account.Start_Date__c.Month()+i, account.Start_Date__c.Day());
                        Contact newContact = new Contact(LastName=newDate.format('MMM')+' '+String.valueOf(newDate.year()), AccountId = account.Id);
                        contactList.add(newContact)
                    }
                }
            }
        }
        insert contactList;
    }
}