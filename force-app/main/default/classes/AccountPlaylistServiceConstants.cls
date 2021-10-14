/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceConstants {
    public static final String ACCOUNT_NAME_REQUEST_PARAMETER = 'accountName';
    public static final String PLAYLIST_NAME_REQUEST_PARAMETER = 'playlistDisplayName';
    public static final String URI_SEPARATOR = '/';
    public static final String URI_SPACE = '%20';
    public static final String STRING_SPACE = ' ';
    public static final Boolean ALL_OR_NOTHING_DML = false;

    public enum OUTCOME {SUCCESS, PARTIALSUCCESS, FAILURE}
}