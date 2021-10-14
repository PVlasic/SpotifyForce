/**
 * Created by catalinalexandrutanasie on 14.10.2021.
 */

public with sharing class ServiceUtils {
    public static String obtainValueFromURI(String URI, String separator, Integer indexFromEnd) {
        String partialURI = URI;
        for (Integer i = 0; i < indexFromEnd; i ++) {
            partialURI = partialURI.substringBeforeLast(separator);
        }
        return partialURI.substring(partialURI.lastIndexOf(separator)+1);
    }
}