/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class SecurityUtils {
    private final static String WORDSPACEREGEX = '[^\w]';
    private final static String EMPTYSTRING = '';

    public static String parseAndSecureSOQLParameter(String rawSOQLParameterInput, Boolean removeSpaces) {
        //todo add generic prep steps and refactor
        if (removeSpaces) {
            return String.escapeSingleQuotes(rawSOQLParameterInput).replaceAll(SecurityUtils.WORDSPACEREGEX, SecurityUtils.EMPTYSTRING);
        }
        return String.escapeSingleQuotes(rawSOQLParameterInput)
    }
}