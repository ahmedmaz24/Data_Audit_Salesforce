import { LightningElement, wire } from "lwc";
import getCount from "@salesforce/apex/count.getCountAccountLeft";

export default class RecordCount extends LightningElement {
  @wire(getCount) count;
}