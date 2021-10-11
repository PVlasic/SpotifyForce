/**
 * Created by VLASIP on 10/9/2021.
 */

import { LightningElement, track, wire } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader'
import inputStyle from '@salesforce/resourceUrl/inputStyle';
import filterPlaylist from '@salesforce/apex/FilterSpotifyController.filterPlaylist';

export default class FilterSpotifyTracks extends LightningElement {
    @track lFeatures = ['danceability', 'energy', 'speechiness', 'acousticness', 'instrumentalness', 'liveness', 'valence'];
    @track featuresMap = {};
    @track lParsedParams = [];
    @track stringifiedParams;
    @track message;
    @track filterButtonDisabled;
    connectedCallback() {
        this.filterButtonDisabled = false;
        loadStyle(this, inputStyle)
        .then(() => {});
    }

    handleClick(event) {
        this.filterButtonDisabled = true;
        console.log('Click');
        this.lParsedParams = [];
        this.stringifiedParams = '';
        this.message = '';
        for(let i = 0; i < this.lFeatures.length; ++i) {
            let keyBottom = this.lFeatures[i] + '_bottomLimit';
            let keyTop = this.lFeatures[i]  + '_topLimit';
            if(this.featuresMap[keyBottom] && this.featuresMap[keyTop] && this.featuresMap[keyBottom] < this.featuresMap[keyTop]){
                var parsedParameters = {};
                console.log('if');
                parsedParameters["featureName"] = this.lFeatures[i];
                parsedParameters["bottomLimit"] = this.featuresMap[keyBottom];
                parsedParameters["topLimit"] = this.featuresMap[keyTop];

                console.log(JSON.stringify(parsedParameters));
                this.lParsedParams.push(parsedParameters);
            }
        }

        this.stringifiedParams = JSON.stringify(this.lParsedParams)
        console.log(this.stringifiedParams);
        this.doFiltering;
    }

    handleFormInputChange(event) {
        this.featuresMap[event.target.name] = event.target.value;

        let lParameters = event.target.name.split('_');

        let otherLimit = lParameters[1] == 'bottomLimit' ? 'topLimit' : 'bottomLimit';
        let otherKey = lParameters[0] + '_' + otherLimit;


        if(otherLimit == 'bottomLimit' && (!this.featuresMap[otherKey] || this.featuresMap[event.target.name] <= this.featuresMap[otherKey])){
            this.featuresMap[otherKey] = this.featuresMap[event.target.name];
        } else if(otherLimit == 'topLimit' && (!this.featuresMap[otherKey] || this.featuresMap[event.target.name] >= this.featuresMap[otherKey])){
            this.featuresMap[otherKey] = this.featuresMap[event.target.name];
        }
    }

    @wire(filterPlaylist, { featureLimits: '$stringifiedParams' })
    doFiltering({ error, data }) {
       if (data) {
           this.message = data;
       } else if (error) {
           this.message = 'Unknown error';
           if (Array.isArray(error.body)) {
               this.message = error.body.map(e => e.message).join(', ');
           } else if (typeof error.body.message === 'string') {
               this.message = error.body.message;
           }
       }
       this.filterButtonDisabled = false;
   }

    get danceabilityBottomValue() {
        if(this.featuresMap?.["danceability_bottomLimit"]){
            return this.featuresMap?.["danceability_bottomLimit"];
        }
        return 0;
    }

    get danceabilityTopValue() {
        if(this.featuresMap?.["danceability_topLimit"]){
            return this.featuresMap?.["danceability_topLimit"];
        }
        return 0;
    }

    get energyBottomValue() {
        if(this.featuresMap?.["energy_bottomLimit"]){
            return this.featuresMap?.["energy_bottomLimit"];
        }
        return 0;
    }

    get energyTopValue() {
        if(this.featuresMap?.["energy_topLimit"]){
            return this.featuresMap?.["energy_topLimit"];
        }
        return 0;
    }

    get speechinessBottomValue() {
        if(this.featuresMap?.["speechiness_bottomLimit"]){
            return this.featuresMap?.["speechiness_bottomLimit"];
        }
        return 0;
    }

    get speechinessTopValue() {
        if(this.featuresMap?.["speechiness_topLimit"]){
            return this.featuresMap?.["speechiness_topLimit"];
        }
        return 0;
    }

    get instrumentalnessBottomValue() {
        if(this.featuresMap?.["instrumentalness_bottomLimit"]){
            return this.featuresMap?.["instrumentalness_bottomLimit"];
        }
        return 0;
    }

    get instrumentalnessTopValue() {
        if(this.featuresMap?.["instrumentalness_topLimit"]){
            return this.featuresMap?.["instrumentalness_topLimit"];
        }
        return 0;
    }

    get livenessBottomValue() {
        if(this.featuresMap?.["liveness_bottomLimit"]){
            return this.featuresMap?.["liveness_bottomLimit"];
        }
        return 0;
    }

    get livenessTopValue() {
        if(this.featuresMap?.["liveness_topLimit"]){
            return this.featuresMap?.["liveness_topLimit"];
        }
        return 0;
    }

    get valenceBottomValue() {
        if(this.featuresMap?.["valence_bottomLimit"]){
            return this.featuresMap?.["valence_bottomLimit"];
        }
        return 0;
    }

    get valenceTopValue() {
        if(this.featuresMap?.["valence_topLimit"]){
            return this.featuresMap?.["valence_topLimit"];
        }
        return 0;
    }

    get acousticnessBottomValue() {
        if(this.featuresMap?.["acousticness_bottomLimit"]){
            return this.featuresMap?.["acousticness_bottomLimit"];
        }
        return 0;
    }

    get acousticnessTopValue() {
        if(this.featuresMap?.["acousticness_topLimit"]){
            return this.featuresMap?.["acousticness_topLimit"];
        }
        return 0;
    }

}