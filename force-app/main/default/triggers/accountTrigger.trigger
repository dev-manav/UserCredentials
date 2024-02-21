trigger accountTrigger on Account (after insert, after update) {

    if(Trigger.isAfter && Trigger.isInsert)
    {
        CreateContact conCreate = new CreateContact();
        conCreate.contactCreateOnInsert(trigger.new);
    }

    if(Trigger.isAfter && Trigger.isUpdate){
        CreateContact conCreate = new CreateContact();
        conCreate.contactCreateOnUpdate(trigger.new, trigger.oldMap);
    }
}