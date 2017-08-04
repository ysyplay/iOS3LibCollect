var CONNECT =(function(){
    //此段代码用来和后台通讯和  发送http请求
var extensionId=null;
var port=null;
    return {
        init:function(){
            var self=this;
            self.listenBackground();
            //获得扩展的ID
        },
        sendToBackground:function(method,data){
            var self= this;
            switch(method){
                case "get_cookies":
                    window.postMessage({ type: method, data: data}, "*");
                    break;
                case "rpc_data":
                    self.HttpSend(data)
                            .done(function(json, textStatus, jqXHR) {
                                CORE.setMessage("下载成功!赶紧去看看吧~", "MODE_SUCCESS");

                            })
                            .fail(function(jqXHR, textStatus, errorThrown) {
                                CORE.setMessage("下载失败!是不是没有开启aria2?", "MODE_FAILURE");
                            }); 
                    break;
                case "rpc_version":
                    self.HttpSend(data)
                            .done(function(json, textStatus, jqXHR) {
                                $("#send_test").html("ARIA2\u7248\u672c\u4e3a\uff1a\u0020" + json.result.version);

                            })
                            .fail(function(jqXHR, textStatus, errorThrown) {
                                $("#send_test").html("错误,请查看是否开启Aria2");
                            }); 
                    break;
            }
        },
        sendToHttp:function(method,data){
            var self=this;
            switch(method){
                case "rpc_data":
                    self.HttpSend(data)
                            .done(function(json, textStatus, jqXHR) {
                                CORE.setMessage("下载成功!赶紧去看看吧~", "MODE_SUCCESS");

                            })
                            .fail(function(jqXHR, textStatus, errorThrown) {
                                CORE.setMessage("下载失败!是不是没有开启aria2?", "MODE_FAILURE");
                            }); 
                    break;
            }
        },
        listenBackground:function(){
            window.addEventListener("message", function(event) {
                if (event.origin != window.location.origin)
                    return;  
                switch(event.data.type){
                    case "send_cookies":
                        if(event.data.data){
                            CORE.setCookies(event.data.data);
                            
                        }else{
                            console.log(event.data.data);
                        }
                        break;
                }

            }, false)

        },
        HttpSend:function(info) {
            Promise.prototype.done=Promise.prototype.then;
            Promise.prototype.fail=Promise.prototype.catch;
            return new Promise(function(resolve, reject) {
                var http = new XMLHttpRequest();
                var contentType = "\u0061\u0070\u0070\u006c\u0069\u0063\u0061\u0074\u0069\u006f\u006e\u002f\u0078\u002d\u0077\u0077\u0077\u002d\u0066\u006f\u0072\u006d\u002d\u0075\u0072\u006c\u0065\u006e\u0063\u006f\u0064\u0065\u0064\u003b\u0020\u0063\u0068\u0061\u0072\u0073\u0065\u0074\u003d\u0055\u0054\u0046\u002d\u0038";
                var timeout = 3000;
                if (info.contentType != null) {
                    contentType = info.contentType;
                }
                if (info.timeout != null) {
                    timeout = info.timeout;
                }
                var timeId = setTimeout(httpclose, timeout);
                function httpclose() {
                    http.abort();
                }
                http.onreadystatechange = function() {
                    if (http.readyState == 4) {
                        if ((http.status == 200 && http.status < 300) || http.status == 304) {
                            clearTimeout(timeId);
                            if (info.dataType == "json") {
                                resolve(JSON.parse(http.responseText), http.status, http);
                            }
                            else if (info.dataType == "SCRIPT") {
                                // eval(http.responseText);
                                resolve(http.responseText, http.status, http);
                            }
                        }
                        else {
                            clearTimeout(timeId);
                            reject(http, http.statusText, http.status);
                        }
                    }
                }
                http.open(info.type, info.url, true);
                http.setRequestHeader("Content-type", contentType);
                for (h in info.headers) {
                    if (info.headers[h]) {
                        http.setRequestHeader(h, info.headers[h]);
                    }
                }
                if (info.type == "POST") {
                    http.send(info.data);
                }
                else {
                    http.send();
                }                          
            });
        }
    }
})();
CONNECT.init();