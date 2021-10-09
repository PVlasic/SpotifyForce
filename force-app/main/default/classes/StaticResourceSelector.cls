/**
 * Created by VLASIP on 10/9/2021.
 */

public class StaticResourceSelector {
    public static List<StaticResource> getStaticResourcesByNames(Set<String> sNames){
        return [SELECT Name, Body FROM StaticResource WHERE Name IN :sNames];
    }
}