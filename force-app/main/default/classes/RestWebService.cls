/**
 * Created by VLASIP on 10/5/2021.
 */

@RestResource(urlMapping='/Playlist/*')
global class RestWebService {

    @HttpPost
    global static void filterPlaylist() {
        try{
            RestRequest request = RestContext.request;

            SpotifyComponents.FilterPlaylistRequest filterRequest =
                    (SpotifyComponents.FilterPlaylistRequest) JSON.deserialize(request.requestBody.toString(), SpotifyComponents.FilterPlaylistRequest.class);


            SpotifyOperations.filterPlaylist(filterRequest.playlistName, filterRequest.filters);
        } catch (Exception e){

        }
    }
}