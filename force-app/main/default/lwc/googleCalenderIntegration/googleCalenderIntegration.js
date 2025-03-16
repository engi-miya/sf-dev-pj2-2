import { LightningElement } from 'lwc';
// @salesforce/apex/クラス名.メソッド名 の形式で指定
import getCalenderEvents from '@salesforce/apex/GoogleCalendarService.getCalenderEvents';

export default class GoogleCalenderIntegration extends LightningElement {
    events = [];
    error;

    async handleFetchEvents() {
        try {
            const data = await getCalenderEvents();
            this.events = data;
            this.error = undefined;
        } catch {
            this.error = error;
            this.events = [];
        }
    }
}