/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class SongSelector {
    public static Song__c getSongByName(String songName) {
        for (Song__c queriedSong : [SELECT Id, Author__c, ReleaseYear__c FROM Song__c WHERE Name = :songName]) {
            return queriedSong;
        }
        return null;
    }
}