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

        public Map<String, Decimal> mFieldNameToValue{
            get{
                if(mFieldNameToValue == null){
                    mFieldNameToValue = new Map<String, Decimal>();
                    mFieldNameToValue.put('danceability', this.danceability);
                    mFieldNameToValue.put('energy', this.energy);
                    mFieldNameToValue.put('loudness', this.loudness);
                    mFieldNameToValue.put('speechiness', this.speechiness);
                    mFieldNameToValue.put('acousticness', this.acousticness);
                    mFieldNameToValue.put('instrumentalness', this.instrumentalness);
                    mFieldNameToValue.put('liveness', this.liveness);
                    mFieldNameToValue.put('valence', this.valence);
                    mFieldNameToValue.put('tempo', this.tempo);
                    return mFieldNameToValue;
                } else {
                    return mFieldNameToValue;
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

    public class PlaylistResponse{
        public HttpResponse response{get;set;}
        public Map<String, String> mSongIdsToUris{
            get{
                if(mSongIdsToUris == null){
                    mSongIdsToUris = new Map<String, String>();
                }
                return mSongIdsToUris;
            }
            set;
        }

        public Map<String, String> mSongIdsToNames{
            get{
                if(mSongIdsToNames == null){
                    mSongIdsToNames = new Map<String, String>();
                }
                return mSongIdsToNames;
            }
            set;
        }
    }

    public class SongFeaturesResponse{
        public HttpResponse response{get;set;}
        public Map<String, SongFeatures> mSongIdToFeatures{
            get{
                if(mSongIdToFeatures == null){
                    mSongIdToFeatures = new Map<String, SpotifyComponents.SongFeatures>();
                }
                return mSongIdToFeatures;
            }
            set;
        }
    }
}