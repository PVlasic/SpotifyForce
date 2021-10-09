/**
 * Created by VLASIP on 10/9/2021.
 */
@IsTest
public class SpotifyOperationsTest {
    @IsTest
    public static void filteringTest(){
        Test.setMock(HttpCalloutMock.class, new SpotifyCalloutsMock());
        List<SpotifyComponents.AudioFeatureFilter> lFeatureFilters = new List<SpotifyComponents.AudioFeatureFilter>();
        SpotifyComponents.AudioFeatureFilter featureFilter = new SpotifyComponents.AudioFeatureFilter();
        featureFilter.featureName = 'danceability';
        featureFilter.bottomLimit = 0.5;
        featureFilter.topLimit = 0.6;

        lFeatureFilters.add(featureFilter);

        //adding non existing filter for code coverage
        featureFilter = new SpotifyComponents.AudioFeatureFilter();
        featureFilter.featureName = 'nonExistingFilter';
        featureFilter.bottomLimit = 0.5;
        featureFilter.topLimit = 0.6;

        lFeatureFilters.add(featureFilter);

        HttpResponse response = SpotifyOperations.filterPlaylist('Generated Playlist', lFeatureFilters);
        System.assertEquals(201, response.getStatusCode());

        //no filter
        response = SpotifyOperations.filterPlaylist('Generated Playlist', null);
        System.assertEquals(201, response.getStatusCode());

        //negative scenarios
        response = SpotifyOperations.filterPlaylist('Mixed Playlist', lFeatureFilters);
        System.assertEquals(403, response.getStatusCode());

        response = SpotifyOperations.filterPlaylist('Non Existing Playlist', lFeatureFilters);
        System.assertEquals(404, response.getStatusCode());

    }
}