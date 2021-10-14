/**
 * Created by catalinalexandrutanasie on 14.10.2021.
 */

public with sharing class ServiceUtils {
    public static String obtainValueFromURI(String URI, String separator, Integer indexFromEnd) {
        String partialURI = URI;
        for (Integer i = 0; i < indexFromEnd; i ++) {
            partialURI = partialURI.substringBeforeLast(separator);
        }
        return ServiceUtils.preProcessURLParameter(partialURI.substring(partialURI.lastIndexOf(separator)+1));
    }

    public static String preProcessURLParameter(String rawValue) {
        return rawValue.replaceAll(AccountPlaylistServiceConstants.URISPACE, AccountPlaylistServiceConstants.STRINGSPACE);
    }
}