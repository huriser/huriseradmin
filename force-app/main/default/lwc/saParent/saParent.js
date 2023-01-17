import { publish, MessageContext } from 'lightning/messageService';//Mesaj içeriğini oluşturmak ve göndermek için kullanılan message service metodlarını import ediyoruz.
import SA_LIST_MESSAGE from '@salesforce/messageChannel/SAmessageChannel__c';//oluşturduğumuz message channeli kullanabilmek için import etmemiz gerekiyor.
import { LightningElement, wire } from 'lwc';
import getSa from '@salesforce/apex/saDetailsController.getSaDetails';
import findSaDetails from '@salesforce/apex/saDetailsController.findSaDetails';
import { NavigationMixin } from 'lightning/navigation';

export default class SaParent extends NavigationMixin(LightningElement) {
    sainfos;
    @wire(MessageContext) messageContext;

    @wire (getSa)  //Class'tan gelen 
    loadSA(result) {
        this.sainfos = result;
        if (result.data) {
    const message = {
        agents: result.data
    };
    publish(this.messageContext, SA_LIST_MESSAGE, message);
  }
};
    searchText = '';
    sainfos2;
    error2;

    handleKeyChange(event) {
        this.searchText = event.target.value;

        findSaDetails({ searchKey: this.searchText })
            .then((result) => {
                this.sainfos2 = result;
                this.error2 = undefined;
                const message = {
                    agents: result
                };
                publish(this.messageContext, SA_LIST_MESSAGE, message);
            })
            .catch((error) => {
                this.error2 = error;
                this.sainfos2 = undefined;
                
            });
    }
    handlesaDetailView(event) {
		
		const recId = event.detail;
		
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: recId,
				objectApiName: 'SA_Detail_TR1__c',
				actionName: 'view',
			},
		});

    
}
}