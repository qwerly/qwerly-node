var Qwerly, api, functions, http, v1_apis, _fn;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
}, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
http = require("http");
Qwerly = (function() {
  function Qwerly() {}
  Qwerly.prototype.getter = function(path, callback) {
    var client, get_str, headers, req;
    if (this.domain == null) {
      throw new Error("No domain set.");
    }
    client = http.createClient(80, this.domain);
    headers = {
      "Host": this.domain,
      "User-Agent": "qwerly-node HTTP client",
      "Content-Length": "0"
    };
    get_str = ("http://" + this.domain) + this.path(path);
    req = client.request("GET", get_str, headers);
    req.on("response", function(response) {
      var body;
      response.setEncoding("utf8");
      body = [];
      response.on("data", function(chunk) {
        return body.push(chunk);
      });
      return response.on("end", function() {
        var body_str, error_details;
        body_str = body.join("");
        if (response.statusCode !== 200) {
          error_details = {
            status: response.statusCode,
            reason: response.headers['x-mashery-error-code'],
            body: body_str
          };
          callback(error_details, null);
        }
        return callback(null, JSON.parse(body_str));
      });
    });
    return req.end();
  };
  return Qwerly;
})();
exports.V1 = (function() {
  __extends(V1, Qwerly);
  function V1(api_key) {
    this.api_key = api_key;
    this.domain = "api.qwerly.com";
    this.path_prefix = "/v1";
  }
  V1.prototype.path = function(extra) {
    return this.path_prefix + extra + "?api_key=" + this.api_key;
  };
  return V1;
})();
v1_apis = {
  userApi: {
    viaTwitter: "/twitter/%{s}.json",
    viaQwerly: "/users/%{s}.json",
    viaFacebook: "/facebook/%{s}.json"
  },
  serviceApi: {
    viaTwitter: "/twitter/%{s}/services.json",
    viaQwerly: "/users/%{s}/services.json",
    viaFacebook: "/facebook/%{s}/services.json"
  }
};
_fn = function(functions) {
  exports.V1.prototype[api] = function() {
    var all, name, path, _fn;
    all = {};
    _fn = __bind(function(path) {
      return all[name] = __bind(function(id, callback) {
        var id_path;
        id_path = path.replace(/%\{s\}/g, id);
        return this.getter(id_path, callback);
      }, this);
    }, this);
    for (name in functions) {
      path = functions[name];
      _fn(path);
    }
    return all;
  };
  return true;
};
for (api in v1_apis) {
  functions = v1_apis[api];
  _fn(functions);
}