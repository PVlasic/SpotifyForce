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

    public static void filterPlaylist(String playlistName, List<SpotifyComponents.AudioFeatureFilter> lFeaturesFilters){

        //not allowed to edit main playlist
        if(playlistName == MAIN_PLAYLIST){
            return;
        }

        //get playlist to generate mapping
        PlaylistMapping__mdt playlistToGenerateMapping = PlaylistMapping__mdt.getInstance(playlistName.deleteWhitespace());

        //sent album does not exist
        if(playlistToGenerateMapping == null){
            return;
        }

        //remove existing songs from the playlist
        Map<String, String> mSongIdToUri = SpotifyCallouts.getPlaylistSongs(playlistToGenerateMapping.PlaylistId__c);
        SpotifyCallouts.removeSongsFromPlaylist(playlistToGenerateMapping.PlaylistId__c, mSongIdToUri.values());

        //get all songs from the main playlist
        mSongIdToUri = SpotifyCallouts.getPlaylistSongs(mainPlaylistMapping.PlaylistId__c);

        Map<String, SpotifyComponents.SongFeatures> mAllSongsFeatures = SpotifyCallouts.getSongsFeatures(mSongIdToUri.keySet());
        List<String> filteredIds = doFiltering(mAllSongsFeatures, lFeaturesFilters);
        List<String> filteredUris = new List<String>();

        for(String songId: filteredIds){
            filteredUris.add(mSongIdToUri.get(songId));
        }

        //adding filtered songs to the generated playlist
        SpotifyCallouts.addSongsToPlaylist(playlistToGenerateMapping.PlaylistId__c, filteredUris);
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
                Decimal featureValue = songFeatures.getFieldValueByName.get(featureFilter.featureName);
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