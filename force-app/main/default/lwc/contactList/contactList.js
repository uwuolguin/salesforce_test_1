import { LightningElement, wire } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import REVENUE_FIELD from '@salesforce/schema/Contact.LastName';
import INDUSTRY_FIELD from '@salesforce/schema/Contact.Email';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    { label: 'Contact First Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Contact Last Name', fieldName: REVENUE_FIELD.fieldApiName, type: 'text' },
    { label: 'Contact Email', fieldName: INDUSTRY_FIELD.fieldApiName, type: 'text' }
];
export default class AccountList extends LightningElement {
    columns = COLUMNS;
    @wire(getContacts)
    contacts;
    
    get errors() {
    return (this.accounts.error) ?
        reduceErrors(this.accounts.error) : [];
}
}