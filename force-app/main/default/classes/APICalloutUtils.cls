/**
 * Created by VLASIP on 10/3/2021.
 */

public class APICalloutUtils {
    public static final String HTTP_GET = 'GET';
    public static final String HTTP_POST = 'POST';
    public static final String HTTP_DELETE = 'DELETE';

    public static HttpResponse compileAndSendHttpRequest(String endpoint, String httpMethod,
            Map<String, String> mQueryParameters, String requestBody){

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setMethod(httpMethod);
        request.setEndpoint(endpoint + compileQueryParams(mQueryParameters));

        if(requestBody != null){
            request.setBody(requestBody);
        }

        HttpResponse response = http.send(request);
        System.debug(response);
        return response;
    }

    public static HttpResponse compileHttpResponse(Integer statusCode, String message){
        HttpResponse response = new HttpResponse();
        response.setStatusCode(statusCode);
        response.setBody(message);
        return response;
    }

    private static String compileQueryParams(Map<String, String> mQueryParams){
        String queryParams = '';

        if(mQueryParams == null){
            return queryParams;
        }
        for(String queryParam: mQueryParams.keySet()){
            queryParams += '?' + queryParam + '=' + mQueryParams.get(queryParam);
        }

        return queryParams;
    }


}