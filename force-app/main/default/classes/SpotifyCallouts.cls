/**
 * Created by VLASIP on 10/2/2021.
 */

public with sharing class SpotifyCallouts {
    public static final String SPOTIFY_CREDENTIALS = 'callout:APISpotify';
    public static final String PLAYLISTS_PATH = '/v1/playlists/';
    public static final String AUDIO_PATH = '/v1/audio-features';
    public static final String TRACK_PATH = '/tracks';


    public static Map<String, SpotifyComponents.SongFeatures> getSongsFeatures(Set<String> sSongIds){
        Map<String, SpotifyComponents.SongFeatures> mSongIdToFeatures = new Map<String, SpotifyComponents.SongFeatures>();

        if(sSongIds.isEmpty())
            return mSongIdToFeatures;

        String songIdsJoined = String.join((Iterable<String>)sSongIds, ',');

        Map<String, String> mQueryParameters = new Map<String, String>();
        mQueryParameters.put('ids', songIdsJoined);

        //callout:APISpotify/v1/audio-features?ids=
        HttpResponse response = APICalloutUtils.compileAndSendHttpRequest(SPOTIFY_CREDENTIALS + AUDIO_PATH,
                APICalloutUtils.HTTP_GET, mQueryParameters, null);


        if(response.getStatusCode() == 200) {
            SpotifyComponents.SongsFeatures songsFeatures = (SpotifyComponents.SongsFeatures) JSON.deserialize(response.getBody(), SpotifyComponents.SongsFeatures.class);

            for(SpotifyComponents.SongFeatures songFeatures: songsFeatures.audio_features){
                System.debug('=========================');
                System.debug('id: ' + songFeatures.Id);
                System.debug('danceability: ' + songFeatures.danceability);
                System.debug('speechiness: ' + songFeatures.speechiness);
                System.debug('liveness: ' + songFeatures.liveness);
                System.debug('energy: ' + songFeatures.energy);
                System.debug('instrumentalness: ' + songFeatures.instrumentalness);
                System.debug('acousticness: ' + songFeatures.acousticness);
                System.debug('loudness: ' + songFeatures.loudness);
                System.debug('tempo: ' + songFeatures.tempo);
                System.debug('=========================');
                mSongIdToFeatures.put(songFeatures.id, songFeatures);
            }
        } else {
            System.debug('Status code: ' + response.getStatusCode());
            System.debug('Response body' + response.getBody());
        }

        return mSongIdToFeatures;
    }

    public static Map<String, String> getPlaylistSongs(String playlistId){
        //TODO: refactor with /tracks
        Map<String, String> mSongIdsToUris = new Map<String, String>();

        if(String.isBlank(playlistId))
            return mSongIdsToUris;

        //endpoint: 'callout:APISpotify/v1/playlists/' + playlistId
        HttpResponse response = APICalloutUtils.compileAndSendHttpRequest(SPOTIFY_CREDENTIALS + PLAYLISTS_PATH + playlistId,
                APICalloutUtils.HTTP_GET, null, null);

        if(response.getStatusCode() == 200) {

            SpotifyComponents.Playlist playlist =
                    (SpotifyComponents.Playlist) JSON.deserialize(response.getBody(), SpotifyComponents.Playlist.class);

            for(SpotifyComponents.Item item: playlist.tracks.items){
                System.debug('Song Id: ' + item.track.id + ' , Song Name: ' + item.track.name);
                mSongIdsToUris.put(item.track.id, item.track.uri);
            }
        } else {
            System.debug('Status code: ' + response.getStatusCode());
            System.debug('Response body' + response.getBody());
        }

        return mSongIdsToUris;
    }

    public static void addSongsToPlaylist(String playlistId, List<String> lSongUris){
        if(lSongUris.isEmpty())
            return;

        //'callout:APISpotify/v1/playlists/' + playlistId + '/tracks'
        HttpResponse response = APICalloutUtils.compileAndSendHttpRequest(SPOTIFY_CREDENTIALS + PLAYLISTS_PATH + playlistId + TRACK_PATH,
                APICalloutUtils.HTTP_POST, null, JSON.serialize(buildAddSongsBody(lSongUris)));

        if(response.getStatusCode() == 201) {
            System.debug('Songs added!');
        } else {
            System.debug('Status code: ' + response.getStatusCode());
            System.debug('Response body' + response.getBody());
        }
    }

    public static void removeSongsFromPlaylist(String playlistId, List<String> lSongUris){
        if(lSongUris.isEmpty())
            return;

        //'callout:APISpotify/v1/playlists/' + playlistId + '/tracks'
        HttpResponse response = APICalloutUtils.compileAndSendHttpRequest(SPOTIFY_CREDENTIALS + PLAYLISTS_PATH + playlistId + TRACK_PATH,
                APICalloutUtils.HTTP_DELETE, null, JSON.serialize(buildRemoveSongsBody(lSongUris)));

        if(response.getStatusCode() == 200) {
            System.debug('Songs deleted!');
        } else {
            System.debug('Status code: ' + response.getStatusCode());
            System.debug('Response body' + response.getBody());
        }
    }

    private static SpotifyComponents.TrackUriList buildRemoveSongsBody(List<String> lSongUris){
        SpotifyComponents.TrackUriList trackUriList = new SpotifyComponents.TrackUriList();
        trackUriList.tracks = new List<SpotifyComponents.UriObject>();
        for(String currentUri: lSongUris){
            SpotifyComponents.UriObject uriObject = new SpotifyComponents.UriObject();
            uriObject.uri = currentUri;
            trackUriList.tracks.add(uriObject);
        }

        return trackUriList;
    }

    private static SpotifyComponents.UrisList buildAddSongsBody(List<String> lSongUris){
        SpotifyComponents.UrisList urisList  = new SpotifyComponents.UrisList();
        urisList.uris = new List<String>();
        for(String uri: lSongUris){
            urisList.uris.add(uri);
        }

        return urisList;
    }

}
