/**
 * Created by VLASIP on 10/9/2021.
 */
@IsTest
public class SpotifyCalloutsTest {
    @IsTest
    public static void getSongsFeaturesTest(){
        Test.setMock(HttpCalloutMock.class, new SpotifyCalloutsMock());

        SpotifyComponents.SongFeaturesResponse mResults = SpotifyCallouts.getSongsFeatures(SpotifyCalloutsMock.sSongIds);

        System.assertEquals(200, mResults.response.getStatusCode());
        //features from 4 songs expected based on the static resource used in mock class
        System.assert(mResults.mSongIdToFeatures.keySet().size() == 4);

        for(SpotifyComponents.SongFeatures feature: mResults.mSongIdToFeatures.values()){
            System.assert(feature.danceability > 0);
            System.assert(feature.liveness > 0);
            System.assert(feature.speechiness > 0);
        }

        //negative scenario
        mResults = SpotifyCallouts.getSongsFeatures(null);
        System.assertEquals(200, mResults.response.getStatusCode());
        System.assert(mResults.mSongIdToFeatures.keySet().size() == 0);
    }
    @IsTest
    public static void getPlaylistSongsTest(){
        Test.setMock(HttpCalloutMock.class, new SpotifyCalloutsMock());

        SpotifyComponents.PlaylistResponse mResults = SpotifyCallouts.getPlaylistSongs(SpotifyCalloutsMock.MAIN_PLAYLIST_ID);


        System.assertEquals(200, mResults.response.getStatusCode());
        //4 songs expected in the playlist based on the static resource used in mock class
        System.assertEquals(4, mResults.mSongIdsToUris.size());

        //negative scenario
        mResults = SpotifyCallouts.getPlaylistSongs(null);
        System.assertEquals(404, mResults.response.getStatusCode());
        System.assertEquals(0, mResults.mSongIdsToUris.size());
    }
    @IsTest
    public static void addSongsToPlaylistTest(){
        Test.setMock(HttpCalloutMock.class, new SpotifyCalloutsMock());

        HttpResponse response = SpotifyCallouts.addSongsToPlaylist(SpotifyCalloutsMock.GENERATED_PLAYLIST_ID, SpotifyCalloutsMock.lSongUrisToAdd);

        System.assert(response.getStatusCode() == 201);

        //negative scenario
        response = SpotifyCallouts.addSongsToPlaylist(SpotifyCalloutsMock.GENERATED_PLAYLIST_ID, null);
        System.assert(response.getStatusCode() == 200);
    }
    @IsTest
    public static void removeSongsFromPlaylistTest(){
        Test.setMock(HttpCalloutMock.class, new SpotifyCalloutsMock());

        HttpResponse response = SpotifyCallouts.removeSongsFromPlaylist(SpotifyCalloutsMock.GENERATED_PLAYLIST_ID, SpotifyCalloutsMock.lSongUrisToRemove);

        System.assert(response.getStatusCode() == 200);

        //negative scenario
        response = SpotifyCallouts.removeSongsFromPlaylist(SpotifyCalloutsMock.GENERATED_PLAYLIST_ID, null);
        System.assert(response.getStatusCode() == 400);
    }
}