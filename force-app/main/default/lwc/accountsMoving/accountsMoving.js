import { LightningElement, wire } from "lwc";
import getCount from "@salesforce/apex/count.getCountAccountMovedOut";

export default class accountMoving extends LightningElement {
  @wire(getCount) count;
}