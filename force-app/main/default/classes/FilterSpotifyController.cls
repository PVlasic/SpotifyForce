/**
 * Created by VLASIP on 10/10/2021.
 */

public with sharing class FilterSpotifyController {
    @AuraEnabled(Cacheable = true)
    public static String filterPlaylist(String featureLimits){
        List<SpotifyComponents.AudioFeatureFilter> lFeaturesFilters =
                (List<SpotifyComponents.AudioFeatureFilter>) JSON.deserialize(featureLimits, List<SpotifyComponents.AudioFeatureFilter>.class);

        HttpResponse response = SpotifyOperations.filterPlaylist('Generated Playlist', lFeaturesFilters);

        if(response.getStatusCode() == 200 || response.getStatusCode() == 201){
            return 'Playlist successfully updated.';
        }

        return 'Something went wrong. Playlist was not updated. Status code: ' + response.getStatusCode() + ' ' + response.getBody();
    }
}