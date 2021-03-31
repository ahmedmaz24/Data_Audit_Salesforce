public with sharing class EmailClass {
@AuraEnabled(cacheable=true)

public static void getEmailSend(List<Integer> content){

String text = FormulateMessage.getFormulate(content);


Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] { 'ahmedmediouni24@hotmail.com' };
message.optOutPolicy = 'FILTER';
message.subject = 'Data Change Logs';
message.plainTextBody = 'Greeitngs Admin,\n\n Data Change Operation Requested on '+ System.now()+' are :\n'+text;
Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

if (results[0].success) {
System.debug('The email was sent successfully.');
} else {
System.debug('The email failed to send: ' + results[0].errors[0].message);
}
}
}
