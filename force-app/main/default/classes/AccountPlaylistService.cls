/**
 * Created by catalinalexandrutanasie on 11.10.2021.
 */

@RestResource(UrlMapping = '/APS/*')
global with sharing class AccountPlaylistService {
    @HttpGet
    global static List<AccountPLaylist__c> getPlaylistsByAccountName() {
        return
    }
}