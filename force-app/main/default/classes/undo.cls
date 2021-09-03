public with sharing class undo {
    @AuraEnabled()

    public static void  getundo(List<Integer> content){

        
        
List<string> listIdaccount = new List<string>();
List<string> listIdcontact= new List<string>();
List<string> listIdlead = new List<string>();
List<string> listIdopportunity = new List<string>();
string x;

        List<public_dataaudit__x> createdrecords = [SELECT date__c,idi__c,name_of_field__c,name_of_object__c,new_value__c,old_value__c,type_of_change__c,type_of_object__c FROM public_dataaudit__x WHERE idi__c IN : content AND type_of_change__c = 'Create'];
        
        for(public_dataaudit__x i : createdrecords){
            if(i.type_of_object__c == 'Account'){
                listIdaccount.add(i.type_of_object__c);
            }
            if(i.type_of_object__c == 'Contact'){
                //x='\''+i.name_of_object__c+'\'';
                listIdcontact.add(i.name_of_object__c);
            }
            if(i.type_of_object__c == 'Lead'){
                listIdlead.add(i.type_of_object__c);
            }
            else{
                listIdopportunity.add(i.type_of_object__c);
            }

        
        }
        
        List<Account> accountsToDelete = [SELECT ID FROM Account WHERE ID IN:listIdaccount];
        delete accountsToDelete;

        List<Contact> contactsToDelete = [SELECT ID FROM Contact WHERE ID IN:listIdcontact];
        delete contactsToDelete;

        List<Lead> leadsToDelete = [SELECT ID FROM Lead WHERE ID IN:listIdlead];
        delete leadsToDelete;

        List<Opportunity> opportunitiesToDelete = [SELECT ID FROM Opportunity WHERE ID IN:listIdopportunity];
        delete opportunitiesToDelete;



    } }