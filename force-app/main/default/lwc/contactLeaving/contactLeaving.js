import { LightningElement, wire } from "lwc";
import getCountleaving from "@salesforce/apex/count.getCountContactMovedOut";
import getCountjoining from "@salesforce/apex/count.getCountContactJoined";

export default class RecordCount extends LightningElement {
  @wire(getCountleaving) count;
  @wire(getCountjoining) countmove;
}