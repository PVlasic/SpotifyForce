/**
 * Created by VLASIP on 10/2/2021.
 */

public class SpotifyComponents {
    public class SongFeatures{
        public String id{get;set;}
        public String uri{get;set;}
        public Decimal danceability{get;set;}
        public Decimal energy{get;set;}
        public Decimal loudness{get;set;}
        public Decimal speechiness{get;set;}
        public Decimal acousticness{get;set;}
        public Decimal instrumentalness{get;set;}
        public Decimal liveness{get;set;}
        public Decimal valence{get;set;}
        public Decimal tempo{get;set;}
        public String type{get;set;}
        public Integer duration_ms{get;set;}

        public Map<String, Decimal> getFieldValueByName{
            get{
                if(getFieldValueByName == null){
                    getFieldValueByName = new Map<String, Decimal>();
                    getFieldValueByName.put('danceability', this.danceability);
                    getFieldValueByName.put('energy', this.energy);
                    getFieldValueByName.put('loudness', this.loudness);
                    getFieldValueByName.put('speechiness', this.speechiness);
                    getFieldValueByName.put('acousticness', this.acousticness);
                    getFieldValueByName.put('instrumentalness', this.instrumentalness);
                    getFieldValueByName.put('liveness', this.liveness);
                    getFieldValueByName.put('tempo', this.tempo);
                    return getFieldValueByName;
                } else {
                    return getFieldValueByName;
                }
            }
            set;
        }
    }

    public class SongsFeatures{
        public List<SongFeatures> audio_features{get;set;}
    }

    public class Playlist{
        public String id{get;set;}
        public String name{get;set;}
        public String description{get;set;}
        public String type{get;set;}
        public Tracks tracks{get;set;}
    }

    public class Tracks{
        public List<Item> items{get;set;}
        public Integer total{get;set;}
    }
    public class Item{
        public Track track{get;set;}
    }
    public class Track{
        public String id{get;set;}
        public String name{get;set;}
        public String uri{get;set;}
        public Integer popularity{get;set;}
        public String type{get;set;}
        public List<Artist> artists{get;set;}
    }

    public class Artist{
        public String id{get;set;}
        public String name{get;set;}
        public String type{get;set;}
    }

    public class TrackUriList{
        public List<UriObject> tracks{get;set;}
    }
    public class UrisList{
        public List<String> uris{get;set;}
    }
    public class UriObject{
        public String uri{get;set;}
    }

    public class AudioFeatureFilter{
        public String featureName{get;set;}
        public Decimal bottomLimit{get;set;}
        public Decimal topLimit{get;set;}
    }

    public class FilterPlaylistRequest{
        public String playlistName{get;set;}
        public List<AudioFeatureFilter> filters{get;set;}
    }

    public class FilterPlaylistResponse{
        String playlistSnapshot{get;set;}
        Fault fault{get;set;}
    }

    public class Fault{
        Integer errorCode{get;set;}
        String errorMessage{get;set;}
    }
}