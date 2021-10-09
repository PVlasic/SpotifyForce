/**
 * Created by VLASIP on 10/9/2021.
 */
@IsTest
global class SpotifyCalloutsMock implements HttpCalloutMock{

    private static final String ADD_REMOVE_SONGS_RESOURCE = 'SpotifyAddRemoveSongsToPlaylistMockResponse';
    private static final String GET_SONGS_RESOURCE = 'SpotifyGetPlaylistSongsMockResponse';
    private static final String GET_FEATURES_RESOURCE = 'SpotifyGetSongsFeaturesResponseMock';

    private static Set<String> sStaticResourceNames = new Set<String>{
            ADD_REMOVE_SONGS_RESOURCE,
            GET_SONGS_RESOURCE,
            GET_FEATURES_RESOURCE
    };

    public static Set<String> sSongIds = new Set<String>{
            '7uRcUUmZpU4YVZFNVZnyXd',
            '1z3ugFmUKoCzGsI6jdY4Ci',
            '7MAibcTli4IisCtbHKrGMh',
            '2zYzyRzz6pRmhPzyfMEC8s'
    };

    public static List<String> lSongUrisToAdd = new List<String>{
            'spotify:track:7MAibcTli4IisCtbHKrGMh',
            'spotify:track:2zYzyRzz6pRmhPzyfMEC8s'
    };

    public static List<String> lSongUrisToRemove = new List<String>{
            'spotify:track:7MAibcTli4IisCtbHKrGMh',
            'spotify:track:1z3ugFmUKoCzGsI6jdY4Ci',
            'spotify:track:7uRcUUmZpU4YVZFNVZnyXd',
            'spotify:track:2zYzyRzz6pRmhPzyfMEC8s'
    };

    public static String MAIN_PLAYLIST_ID = '3g4bauJeTeCXdeHwVuw1MY';

    public static final String GENERATED_PLAYLIST_ID = '2gUWB3lAyuYX86IcV9JSg7';

    public static final String GET_SONG_FEATURES_ENDPOINT =
            SpotifyCallouts.SPOTIFY_CREDENTIALS + SpotifyCallouts.AUDIO_PATH + '?ids=' + String.join((Iterable<String>)sSongIds, ',');

    public static final String GET_MAIN_PLAYLIST_SONGS_ENDPOINT =
            SpotifyCallouts.SPOTIFY_CREDENTIALS + SpotifyCallouts.PLAYLISTS_PATH + MAIN_PLAYLIST_ID;

    public static final String GET_GENERATED_PLAYLIST_SONGS_ENDPOINT =
            SpotifyCallouts.SPOTIFY_CREDENTIALS + SpotifyCallouts.PLAYLISTS_PATH + GENERATED_PLAYLIST_ID;

    public static final String ADD_REMOVE_PLAYLIST_SONGS_ENDPOINT =
            SpotifyCallouts.SPOTIFY_CREDENTIALS + SpotifyCallouts.PLAYLISTS_PATH  + GENERATED_PLAYLIST_ID + SpotifyCallouts.TRACK_PATH;

    global HttpResponse respond(HttpRequest request) {
        Map<String, String> mResourceNameToBody = getStaticResourceBodies();

        HttpResponse response = new HttpResponse();
        if(request.getMethod() == 'GET' && request.getEndpoint() == GET_SONG_FEATURES_ENDPOINT){

            compileResponse(response, 200, mResourceNameToBody.get(GET_FEATURES_RESOURCE));

        }else if(request.getMethod() == 'GET' && request.getEndpoint() == GET_MAIN_PLAYLIST_SONGS_ENDPOINT){

            compileResponse(response, 200, mResourceNameToBody.get(GET_SONGS_RESOURCE));

        } else if(request.getMethod() == 'GET' && request.getEndpoint() == GET_GENERATED_PLAYLIST_SONGS_ENDPOINT){
            compileResponse(response, 200, mResourceNameToBody.get(GET_SONGS_RESOURCE));
        }
        else if(request.getMethod() == 'POST' && request.getEndpoint() == ADD_REMOVE_PLAYLIST_SONGS_ENDPOINT) {

            compileResponse(response, 201, mResourceNameToBody.get(ADD_REMOVE_SONGS_RESOURCE));

        } else if(request.getMethod() == 'DELETE' && request.getEndpoint() == ADD_REMOVE_PLAYLIST_SONGS_ENDPOINT){

            compileResponse(response, 200, mResourceNameToBody.get(ADD_REMOVE_SONGS_RESOURCE));

        }

        return response;
    }

    private static void compileResponse(HttpResponse response, Integer statusCode, String body){
        response.setStatusCode(statusCode);
        response.setBody(body);
    }

    private static Map<String, String> getStaticResourceBodies(){
        Map<String, String> mResourceNameToBody = new Map<String, String>();
        List<StaticResource> lStaticResources = StaticResourceSelector.getStaticResourcesByNames(sStaticResourceNames);

        for(StaticResource sr: lStaticResources){
            mResourceNameToBody.put(sr.Name, sr.Body.toString());
        }

        return mResourceNameToBody;
    }
}