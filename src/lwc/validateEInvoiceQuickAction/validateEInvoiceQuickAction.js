/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 4.7.2024 г.
 */
import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import validateInvoice from "@salesforce/apex/RomanianEInvoiceWebService.validateEInvoice";
import setInvoiceAsValidated from "@salesforce/apex/XMLInvoiceService.setInvoiceAsValidated";
import { reduceErrors } from 'c/ldsUtils';

export default class ValidateEInvoiceQuickAction extends LightningElement {

	@api recordId;

	successMessage = 'E-Invoice was successfully validated.';
	success = false;
	errorMessage = 'E-Invoice was NOT successfully validated.';
	errorDescription;
	header = 'Generating E-Invoice and Validating'
	loadingSpinner = true;

	connectedCallback(){
		validateInvoice({
							codaInvoiceId: this.recordId
		}).then((result) => {
			setInvoiceAsValidated( {
									   invoiceId: this.recordId
			}).then((result) => {
				this.showToast('Successfully validated eInvoice', 'Validation successful.','success');
			}).catch(error => {
				this.showToast('Error', 'Error occurred while updating the codaInvoice as validated.','error');
			});
			this.success = true;
		}).catch((error) => {
			console.log(reduceErrors(error));
			console.log(error);
			if(error.body.exceptionType === 'RomanianEInvoiceWebService.RomanianGovernmentCalloutException') {
				this.errorDescription = error.body.message;
			} else {
				this.errorDescription = '[Error Message] ' + error.body.message + '\n  [StackTrace] ' + error.body.stackTrace;
			}
		}).finally(
			this.loadingSpinner = false
		);
	}

	showToast(title, message, variant) {
		const event = new ShowToastEvent({
											 title: title,
											 message: message,
											 variant: variant,
											 mode: 'dismissable'
										 });
		this.dispatchEvent(event);
	}

	closeQuickAction() {
		const refreshEvent = new CustomEvent('close');
		this.dispatchEvent(refreshEvent);
	}
}