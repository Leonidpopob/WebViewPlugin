/**
 * Created by Leonid on 3/20/14.
 */
CDV = ( typeof CDV == 'undefined' ? {} : CDV );
var cordova = window.cordova || window.Cordova;
WEBVIEW = {
    show: function(url,lang,adpublisher,pubshow,orient,label,retour) {
        cordova.exec(function(winParam) {console.log(winParam);},
            function(error) {console.log(error);},
            "WEBVIEW",
            "show",
            [url,lang,adpublisher,pubshow,orient,label,retour]);
    }
};
