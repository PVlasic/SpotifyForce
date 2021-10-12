/**
 * Created by VLASIP on 10/3/2021.
 */

public class SpotifyOperations {
    public static final String MAIN_PLAYLIST = 'Mixed Playlist';

    public static PlaylistMapping__mdt mainPlaylistMapping{
        get{
            if(mainPlaylistMapping == null){
                mainPlaylistMapping = PlaylistMapping__mdt.getInstance(MAIN_PLAYLIST.deleteWhitespace());
            }
            return mainPlaylistMapping;
        }
        set;
    }

    public static HttpResponse filterPlaylist(String playlistName, List<SpotifyComponents.AudioFeatureFilter> lFeaturesFilters){

        //not allowed to edit main playlist
        if(playlistName == MAIN_PLAYLIST){
            return APICalloutUtils.compileHttpResponse(403, 'Forbidden to edit the main playlist.');
        }

        //get playlist to generate mapping
        PlaylistMapping__mdt playlistToGenerateMapping = PlaylistMapping__mdt.getInstance(playlistName.deleteWhitespace());

        //sent album does not exist
        if(playlistToGenerateMapping == null){
            return APICalloutUtils.compileHttpResponse(404, 'Playlist not found.');
        }

        //remove existing songs from the playlist
        SpotifyComponents.PlaylistResponse playlistResponse = SpotifyCallouts.getPlaylistSongs(playlistToGenerateMapping.PlaylistId__c);
        if(playlistResponse.response.getStatusCode() != 200){
            System.debug(playlistResponse.response);
            return playlistResponse.response;
        }
        SpotifyCallouts.removeSongsFromPlaylist(playlistToGenerateMapping.PlaylistId__c, playlistResponse.mSongIdsToUris.values());

        //get all songs from the main playlist
        SpotifyComponents.PlaylistResponse mainPlaylistResponse = SpotifyCallouts.getPlaylistSongs(mainPlaylistMapping.PlaylistId__c);
        if(playlistResponse.response.getStatusCode() != 200){
            System.debug(mainPlaylistResponse.response);
            return mainPlaylistResponse.response;
        }

        SpotifyComponents.SongFeaturesResponse songFeaturesResponse = SpotifyCallouts.getSongsFeatures(mainPlaylistResponse.mSongIdsToUris.keySet());
        if(songFeaturesResponse.response.getStatusCode() != 200){
            System.debug(songFeaturesResponse.response);
            return songFeaturesResponse.response;
        }

        //filtering of fetched songs
        List<String> filteredIds = doFiltering(songFeaturesResponse.mSongIdToFeatures, lFeaturesFilters);
        List<String> filteredUris = new List<String>();

        for(String songId: filteredIds){
            filteredUris.add(mainPlaylistResponse.mSongIdsToUris.get(songId));
        }

        //adding filtered songs to the generated playlist
        return SpotifyCallouts.addSongsToPlaylist(playlistToGenerateMapping.PlaylistId__c, filteredUris);
    }

    private static List<String> doFiltering(Map<String, SpotifyComponents.SongFeatures> mAllSongFeatures, List<SpotifyComponents.AudioFeatureFilter> lFeaturesFilters){

        List<String> filteredIds = new List<String>();

        //nothing to filter return all songs
        if(lFeaturesFilters == null || lFeaturesFilters.isEmpty()){
            filteredIds = new List<String>(mAllSongFeatures.keySet());
            return filteredIds;
        }

        for(String songId: mAllSongFeatures.keySet()){
            SpotifyComponents.SongFeatures songFeatures = mAllSongFeatures.get(songId);
            Boolean filterOut = false;
            //looping through every limited feature
            for(SpotifyComponents.AudioFeatureFilter featureFilter: lFeaturesFilters){
                Decimal featureValue = songFeatures.mFieldNameToValue.get(featureFilter.featureName);
                //unknown filter
                if(featureFilter == null)
                    continue;

                //feature breaks limits ->it can be filtered out
                if(featureValue < featureFilter.bottomLimit || featureValue > featureFilter.topLimit){
                    filterOut = true;
                    continue;
                }
            }
            //if song did not break any feature limits it can go through
            if(filterOut == false){
                filteredIds.add(songId);
            }
        }

        return filteredIds;
    }
}