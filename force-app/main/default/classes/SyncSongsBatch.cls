/**
 * Created by VLASIP on 10/13/2021.
 */

global class SyncSongsBatch implements Database.Batchable<SObject>, Database.Stateful {
    List<Song__c> lSongsToInsert = new List<Song__c>();
    Integer countSuccess = 0;
    Integer countError = 0;
    public SyncSongsBatch() {
        //SpotifyComponents.PlaylistResponse playlistResponse = SpotifyCallouts.getPlaylistSongs(SpotifyOperations.MAIN_PLAYLIST);
        SpotifyComponents.PlaylistResponse playlistResponse = SpotifyCallouts.getPlaylistSongs('2Yvrw9RfbUDOTfWzgPfLxu');
        SpotifyComponents.SongFeaturesResponse songFeaturesResponse = SpotifyCallouts.getSongsFeatures(playlistResponse.mSongIdsToUris.keySet());

        for(String songId: playlistResponse.mSongIdsToUris.keySet()){
            Song__c song = new Song__c(
                    SpotifyId__c = songId,
                    SpotifyUri__c = playlistResponse.mSongIdsToUris.get(songId),
                    Name = playlistResponse.mSongIdsToNames.get(songId),
                    Danceability__c = songFeaturesResponse.mSongIdToFeatures.get(songId).danceability,
                    Energy__c = songFeaturesResponse.mSongIdToFeatures.get(songId).energy,
                    Speechiness__c = songFeaturesResponse.mSongIdToFeatures.get(songId).speechiness,
                    Acousticness__c = songFeaturesResponse.mSongIdToFeatures.get(songId).acousticness,
                    Instrumentalness__c = songFeaturesResponse.mSongIdToFeatures.get(songId).instrumentalness,
                    Liveness__c = songFeaturesResponse.mSongIdToFeatures.get(songId).liveness,
                    Valence__c = songFeaturesResponse.mSongIdToFeatures.get(songId).valence
            );
            lSongsToInsert.add(song);
        }

    }

    public List<Song__c> start(Database.BatchableContext context) {
        return lSongsToInsert;
    }

    public void execute(Database.BatchableContext context, List<Song__c> scope) {
        for (Database.SaveResult currentSr : Database.insert(scope, false)) {
            if (currentSr.isSuccess()) {
                ++countSuccess;
            } else {
                ++countError;
            }
        }
    }

    public void finish(Database.BatchableContext context) {
        System.debug('Successfully inserted: ' + countSuccess);
        System.debug('Not inserted: ' + countError);
    }
}