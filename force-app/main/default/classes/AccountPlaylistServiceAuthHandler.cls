/**
 * Created by catalinalexandrutanasie on 14.10.2021.
 */

global with sharing class AccountPlaylistServiceAuthHandler extends Auth.ConnectedAppPlugin {
    global override Boolean authorize(Id userId, Id connectedAppId, Boolean isAdminApproved, Auth.InvocationContext context) {
        System.debug('### UID: ' + userId + ', ' + connectedAppId + ', ' + isAdminApproved + ', ' + context);
        return !UserSelector.isUserOAuthRestricted(userId);
    }
}