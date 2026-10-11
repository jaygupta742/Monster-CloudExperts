import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import LightningAlert from 'lightning/alert';
import { refreshApex } from '@salesforce/apex';
import getalldata from '@salesforce/apex/ShowProducts.Getalldata';
import getptype from '@salesforce/apex/ShowProducts.getptype';
import getproductnames from '@salesforce/apex/ShowProducts.getproductnames';
import getCurrency from '@salesforce/apex/ShowProducts.getCurrency';
import getCountry from '@salesforce/apex/ShowProducts.getCountry';
import Name from '@salesforce/schema/Lead.Name';
export default class ShowProducts extends LightningElement {
    @track alldata;
    @track totalrecord=0;
    @track filterlist;
    @track ptype = '';
    @track pname = '';
    @track selcontry = '';
    @track currency = '';
    @track pmaintype = '';
    @track showlist;
    @track filter2Options = []; // Replace with actual options 
    @track filter4Options = []; // Replace with actual options  
    @track isLoading;

    disconnectedCallback() {
       // alert('Disconnected Cal back')
        this.alldata = [];
        this.filterlist = [];
        this.ptype = '';
        this.pname = '';
        this.selcontry = '';
        this.currency = '';
        this.pmaintype = '';
        this.showlist;
        this.filter2Options = [];
        this.filter4Options = [];
        //alert('Disconnected Cal back')
    }
    @wire(getalldata,{ptye:'$pmaintype',pname:'$pname',selcontry:'$selcontry',curr:'$currency'})
    async oncallback_test(response) {
        this.isLoading = true;
        refreshApex(response);
       
        let data = response.data;
        let error = response.error;

        if (data) {
            console.log(' get p type here '+this.pmaintype);
            this.alldata = data;
            console.log('Product Size ' + this.alldata.length)
          //  this.getfilterlist();
            this.totalrecord = this.alldata.length;
            if (this.alldata.length > 0) {
                /*let no = 0
                let listn = []
                for (let item of this.alldata) {
                    no = no + 1;
                    item.srno = no;
                    listn.push(item);
                }
                this.alldata = listn; */
                this.showlist = true;
            }
            else { this.showlist = false; }
            setTimeout(() => {
                this.isLoading = false;
            }, 2000);
        }
        if (error) {
            let errorMSG = error.body.message;
            //alert('error on calling ' + errorMSG);
            this.showAlert(errorMSG, 'error', 'Error!', () => {
                return;
            });
            this.isLoading = false
        }

    }
    @wire(getproductnames,({ptye:'$pmaintype'}))
    async oncallback_name(response) {
        refreshApex(response);
        this.isLoading = true;
        let data = response.data;
        let error = response.error;

        if (data) {
            //alert('in first test 1')

            this.filter2Options = [{ label: '-None-', value: '' }].concat(
                data.map(item => ({   label: item.label,  value: item.value}))
            );
          /*  this.filter2Options = data.map(item => ({
                label: item.label,
                value: item.value
            })); */
            // console.log('filter2Options new map '+ this.filter2Options)
            this.isLoading = false;
        }
        if (error) {
            let errorMSG = error.body.message;
            alert('error on calling ' + errorMSG);
            this.showAlert(errorMSG, 'error', 'Error!', () => {
                return;
            });
            this.isLoading = false
        }

    }

    async getfilterlist(){
        let ptype = this.pmaintype;
        let duplicates = this.alldata;
        // console.log(duplicates.length +'   console.log(duplicates.length); ');
        let listforpname = [];
        for (let item of duplicates) {
            if (item.p.Product_Type__c == ptype && ptype != '') {
                if (item.p.Product_Name__c != null) listforpname.push(item.p.Product_Name__c);
            }
            else {
                if (item.p.Product_Name__c != null) listforpname.push(item.p.Product_Name__c);
            }
        }
        // console.log(listforpname +'   console.log(listforpname.length); ');
        let list1pcontry = [];
        for (let item of duplicates) {
            if (item.p.Product_Type__c == ptype && ptype != '') {
                //console.log('get countr '+item.p.Product_Type__c);
                if (item.p.Product_Country__c != null) list1pcontry.push(item.p.Product_Country__c);
            }
            else {
                if (item.p.Product_Country__c != null) list1pcontry.push(item.p.Product_Country__c);
            }
        }

        let list2 = listforpname.filter((x, i, a) => a.indexOf(x) === i);
        let list3 = list1pcontry.filter((x, i, a) => a.indexOf(x) === i);
        this.filter2Options = [{ label: '-None-', value: '' }].concat(
            list2.map(item => ({ label: item, value: item }))
        );
        console.log('  list3 ' + list3);
        this.filter4Options = [{ label: '-None-', value: '' }].concat(
            list3.map(item => ({ label: item, value: item }))
        );

        console.log('  filter4Options ' + this.filter4Options);
    }

    @wire(getCountry, ({ptye:'$pmaintype',pname:'$pname'}))
    async oncallback_pcontry(response) {
        // refreshApex(response);
        this.isLoading = true;
        let data = response.data;
        let error = response.error;

        if (data) {
            this.filter4Options = [{ label: '-None-', value: '' }].concat(
                data.map(item => ({   label: item.label,  value: item.value}))
            );
          /*  this.filter4Options = data.map(item => ({
                label: item.label,
                value: item.value
            })); */
            //  console.log('filter4Options new map '+ this.filter4Options)

            this.isLoading = false;
        }
        if (error) {
            let errorMSG = error.body.message;
            alert('error on calling ' + errorMSG);
            this.showAlert(errorMSG, 'error', 'Error!', () => {
                return;
            });
            this.isLoading = false
        }

    }
    async setValues(event) {
        this.isLoading = true;
        let fieldName = event.target.fieldName;
        let value = event.target.value;
        let name = event.target.name;
        // alert(' fieldName ' + fieldName + ' value ' + value+' name '+name)
        if (name == 'Main_Product_Type__c') this.ptype = value
        if (name == 'Product_Type__c') {
            this.pmaintype = value;
           
        }
        if (name == 'Product_Name__c') {
            this.pname = value 
        }
        if (name == 'Product_Country__c') this.selcontry = value
        if (name == 'CurrencyIsoCode') this.currency = value
       // this.isLoading = false;

    }

   /* getfilterlist(event) {
        //alert('on key '+event.key)
        //  alert('type '+this.pmaintype +' name '+this.pname + ' country '+this.selcontry + ' curr '+this.currency)
        if (event.key === 'Enter') {
            if (this.pmaintype == '' && this.pname == '' && this.selcontry == '' && this.currency == '') {
                this.filterlist =[];
                this.showlist = false;
                return;
            }

            let type = this.pmaintype.toLowerCase();
            let name = this.pname.toLowerCase();
            let country = this.selcontry.toLowerCase();
            let curr = this.currency.toLowerCase();


            this.filterlist = this.alldata.filter((item) => {
                let ptype = item.p.Product_Type__c === null || item.p.Product_Type__c === undefined ? '' : item.p.Product_Type__c.toLowerCase();
                let pname = item.p.Product_Name__c === null || item.p.Product_Name__c === undefined ? '' : item.p.Product_Name__c.toLowerCase();
                let psellc = item.p.Product_Country__c === null || item.p.Product_Country__c === undefined ? '' : item.p.Product_Country__c.toLowerCase();
                let pcurr = item.p.CurrencyIsoCode === null || item.p.CurrencyIsoCode === undefined ? '' : item.p.CurrencyIsoCode.toLowerCase();



                return (ptype.includes(type) && pname.includes(name) && psellc.includes(country) && pcurr.includes(curr));
            });

            if (this.filterlist.length > 0) {
                let no = 0
                let listn = []
                for (let item of this.filterlist) {
                    no = no + 1;
                    item.srno = no;
                    listn.push(item);
                }
                this.filterlist = listn;
                this.showlist = true;
            }
            else { this.showlist = false; }
            console.log("temp list : " + this.filterlist.length);
        }

    } */

     @wire(getptype)
    async oncallback_ptype(response){
         refreshApex(response);
        this.isLoading = true;
        let data = response.data;
        let error = response.error;
    
        if(data){
            this.filter1Options = [{ label: '-None-', value: '' }].concat(
                data.map(item => ({   label: item.label,  value: item.value}))
            );
        //    console.log('Pfilter1Options', this.filter1Options);
            
            this.isLoading = false;
        }
        if(error){
            let errorMSG = error.body.message;
            alert('error on calling ' + errorMSG);
            this.showAlert(errorMSG, 'error', 'Error!', () => {
                return;
            });
            this.isLoading = false
        }
    
    }
    
   
    
    @wire(getCurrency)
    async oncallback_psku(response){
        refreshApex(response);
        this.isLoading = true;
        let data = response.data;
        let error = response.error;
    
        if(data){
            this.filter3Options = [{ label: '-None-', value: '' }].concat(
                data.map(item => ({   label: item.label,  value: item.value}))
            );
           // console.log('filter3Options Size '+ data)
            this.isLoading = false;
        }
        if(error){
            let errorMSG = error.body.message;
            alert('error on calling ' + errorMSG);
            this.showAlert(errorMSG, 'error', 'Error!', () => {
                return;
            });
            this.isLoading = false
        }
    
    }
    
   


    async showAlert(message, theme, label, ff) {
        await LightningAlert.open({
            message: message,
            theme: theme,
            label: label,
        });
        console.log('Alert has been closed');
        ff();
    }


}