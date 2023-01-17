import { api, LightningElement } from 'lwc';

export default class SaChild extends LightningElement {
    @api sainfo; //Parentta sainfoya atama yapacagiz
    
    onClickSearch(){
        const selectEvent = new CustomEvent('sadetailview', {
            detail: this.sainfo.Id
        });
        this.dispatchEvent(selectEvent); 
    }
}