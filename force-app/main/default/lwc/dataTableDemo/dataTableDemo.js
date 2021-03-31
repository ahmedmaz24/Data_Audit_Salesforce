import { LightningElement, wire, track, api} from 'lwc';

import getAuddit from '@salesforce/apex/TableController.getAudits'
import getAudditdel from '@salesforce/apex/TableController.getAuditsdelete'
import getAudditupd from '@salesforce/apex/TableController.getAuditsUpdate'
import getAudditcrea from '@salesforce/apex/TableController.getAuditsCreate'
import getContacts from '@salesforce/apex/PdfGenerator.getContactsController';
import getEmailSend from '@salesforce/apex/EmailClass.getEmailSend';
import getEmailSendhistory from '@salesforce/apex/EmailClass.getEmailSendhistory';
import {loadScript} from "lightning/platformResourceLoader";
import JSPDF from '@salesforce/resourceUrl/jspdf';


const COLUMNS = [   
{label : 'ID', fieldName:'idi__c'},
{label : 'Field nname', fieldName:'name_of_field__c'},
{label : 'Object ID', fieldName:'name_of_object__c'},
{label : 'New Value', fieldName:'new_value__c'},
{label : 'Old Value', fieldName:'old_value__c'},
{label : 'Type Of Change', fieldName:'type_of_change__c',cellAttributes:{
class:{fieldName:'ChangeColor'}
}},
{label : 'Type Of Object', fieldName:'type_of_object__c'},
{label : 'Date', fieldName:'date__c'},
{label : 'User', fieldName:'user_audit__c'},





]
export default class DataTableDemo extends LightningElement {
value = '';
show = '';

get options() {
    return [
        { label: 'Update', value: 'Update' },
        { label: 'Delete', value: 'Delete' },
        { label: 'Create', value: 'Create' },
    ];
}

handleChange(event) {
    this.value = event.detail.value;
    if(event.detail.value == 'Delete'){
        
    }
    
    
}

@api content;
contactList = [];

tableData
columns = COLUMNS 
@wire(getAuddit)
auditHandler({data,error}){
if(data){
//if the type of change is delete , paint it in red color 
this.tableData = data.map(item=>{
    let ChangeColor ;
    if(item.type_of_change__c == 'Delete'){
            ChangeColor="slds-text-color_error";
    }else if(item.type_of_change__c =='Create'){
            ChangeColor="slds-text-color_success";

        }else{
        ChangeColor="slds-text-color_default";
    }
    
    

    return{...item,"ChangeColor":ChangeColor}
}) 
console.log(this.tableData)  
}
if(error){
console.error(error)
}
}
//when user select a row or multiple rows , we can see it in the console in user messages (if you using chrome)
//im planning to redirect the "selected" data to pdf file 
handleclick(){
var el = this.template.querySelector('lightning-datatable');

console.log(el);
var selected = el.getSelectedRows();
let selectedIdsArray = [];
for (const element of selected) {
console.log(element.idi__c);
selectedIdsArray.push(element.idi__c);


}
getEmailSend({content : selectedIdsArray}).then(result=>{

})
//console.log(selected);
//console.log(JSON.stringify(selected));

/*getEmailSend({content : JSON.stringify(selected)}).then(result=>{

})*/




}

renderedCallback() {
Promise.all([
    loadScript(this, JSPDF)
]);
}
generatePdf(number){
const { jsPDF } = window.jspdf;
const doc = new jsPDF({
});

var text =[]

let today = new Date().toISOString().slice(0, 10)
text.push("                                    Data Operation Logs for  "+number+today)
//text.push("\n Hi I'm Matt \n"+JSON.stringify(i)+"\n" );

doc.text(text ,10,10)
//doc.table(30, 30, this.contactList, { autosize:true });
doc.save("demo.pdf");
}
//the click method 
pdfclick(){

var el = this.template.querySelector('lightning-datatable');

console.log(el);
var selected = el.getSelectedRows();
let selectedIdsArrayPDF = [];
for (const element of selected) {
console.log(element.idi__c);
selectedIdsArrayPDF.push(element.idi__c)}

getContacts().then(result=>{
    this.generatePdf(5555);

});
}
historyclick(){
var el = this.template.querySelector('lightning-datatable');

console.log(el);
var selected = el.getSelectedRows();
let selectedIdsArray = [];
for (const element of selected) {
    console.log(element.name_of_object__c);
    selectedIdsArray.push(element.name_of_object__c);

}
getEmailSendhistory({content :selectedIdsArray}).then(result=>{

})
}
//this part is kept untill i find a solution for creating table in pdf
/*createHeaders(keys) {
var result = [];
for (var i = 0; i < keys.length; i += 1) {
    result.push({
        id: keys[i],
        name: keys[i],
        prompt: keys[i],
        width: 65,
        align: "center",
        padding: 0
    });
}
return result;
}*/



}