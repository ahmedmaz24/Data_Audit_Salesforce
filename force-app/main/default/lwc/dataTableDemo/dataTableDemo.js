import { LightningElement, wire, track, api} from 'lwc';

import getAuddit from '@salesforce/apex/TableController.getAudits'
import getAudditdel from '@salesforce/apex/TableController.getAuditsdelete'
import getAudditupd from '@salesforce/apex/TableController.getAuditsUpdate'
import getAudditcrea from '@salesforce/apex/TableController.getAuditsCreate'
import getContacts from '@salesforce/apex/PdfGenerator.getContactsController';
import getEmailSend from '@salesforce/apex/EmailClass.getEmailSend';
import getEmailSendhistory from '@salesforce/apex/EmailClass.getEmailSendhistory';
import CSVfile from '@salesforce/apex/CreateCSV.getCSV';
import {loadScript} from "lightning/platformResourceLoader";
import JSPDF from '@salesforce/resourceUrl/jspdf';
import {refreshApex} from '@salesforce/apex';
import formulatemessage from '@salesforce/apex/FormulateMessage.getFormulate';
import ReverseFunctionJS from '@salesforce/apex/undo.getundo';




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
{label : 'Date', fieldName:'date__c' },
{label : 'User', fieldName:'user_audit__c'},





]
export default class DataTableDemo extends LightningElement {
   undoclick(){
    var el = this.template.querySelector('lightning-datatable');

    console.log(el);
    var selected = el.getSelectedRows();
    let selectedIdsArray = [];
    for (const element of selected) {
    console.log(element.idi__c);
    selectedIdsArray.push(element.idi__c);
    
    
    }
    ReverseFunctionJS({content : selectedIdsArray}).then(result=>{
    
    })      
     }


value = 'Default';
show = '';
get options() {
    return [
        { label: 'Default', value: 'Default' },
        { label: 'Update', value: 'Update' },
        { label: 'Delete', value: 'Delete' },
        { label: 'Create', value: 'Create' },
    ];
}


handleChange(event) {
    this.value = event.detail.value;
    
    if(event.detail.value == 'Delete'){
       this.value = 'Delete';
    }
    if(event.detail.value == 'Create'){
        this.value = 'Create' ;

     }
    if(event.detail.value == 'Update'){
        this.value = 'Update';

     }

    
    
}

@api content;
contactList = [];

tableData
columns = COLUMNS 
@wire(getAuddit, {params :'$value'})
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
generatePdf(){
const { jsPDF } = window.jspdf;
const doc = new jsPDF({
});

var text =[]

//let today = new Date().toISOString().slice(0, 10)
text.push("                                    Data Operation Logs for  "+today+'\n')
//text.push("\n Hi I'm Matt \n"+JSON.stringify()+"\n" );

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
selectedIdsArrayPDF.push(element.idi__c)};


getContacts().then(result=>{
    this.generatePdf();

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
@api contents;
// this method validates the data and creates the csv file to download
downloadCSVFile() {   
    let rowEnd = '\n';
    let csvString = '';
    // this set elminates the duplicates if have any duplicate keys
    let rowData = new Set();

    // getting keys from data
    this.tableData.forEach(function (record) {
        Object.keys(record).forEach(function (key) {
            rowData.add(key);
        });
    });

    // Array.from() method returns an Array object from any object with a length property or an iterable object.
    rowData = Array.from(rowData);
    
    // splitting using ','
    csvString += rowData.join(',');
    csvString += rowEnd;

    // main for loop to get the data based on key value
    for(let i=0; i < this.tableData.length; i++){
        let colValue = 0;

        // validating keys in data
        for(let key in rowData) {
            if(rowData.hasOwnProperty(key)) {
                // Key value 
                // Ex: Id, Name
                let rowKey = rowData[key];
                // add , after every value except the first.
                if(colValue > 0){
                    csvString += ',';
                }
                // If the column is undefined, it as blank in the CSV file.
                let value = this.tableData[i][rowKey] === undefined ? '' : this.tableData[i][rowKey];
                csvString += '"'+ value +'"';
                colValue++;
            }
        }
        csvString += rowEnd;
    }

    // Creating anchor element to download
    let downloadElement = document.createElement('a');

    // This  encodeURI encodes special characters, except: , / ? : @ & = + $ # (Use encodeURIComponent() to encode these characters).
    downloadElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvString);
    downloadElement.target = '_self';
    // CSV File Name
    downloadElement.download = 'Audit Data.csv';
    // below statement is required if you are using firefox browser
    document.body.appendChild(downloadElement);
    // click() Javascript function to download CSV file
    downloadElement.click(); 
}


}