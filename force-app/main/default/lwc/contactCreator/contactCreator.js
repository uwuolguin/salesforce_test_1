import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactCreator extends LightningElement {
    fields = ['FirstName', 'LastName', 'Email'];

    handleSuccess(event) {
        const contactId = event.detail.id;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success!',
                message: 'Contact created. Id: ' + contactId,
                variant: 'success'
            })
        );
    }
}
