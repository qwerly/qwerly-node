http = require "http"

class Qwerly
  getter: ( path, callback ) ->
    unless @domain?
      throw new Error "No domain set."

    client  = http.createClient( 80, @domain )
    headers =
      "Host":           @domain,
      "User-Agent":     "qwerly-node HTTP client",
      "Content-Length": "0"

    get_str = "http://#{@domain}" + this.path( path )
    req = client.request "GET", get_str, headers;

    req.on "response", ( response ) ->
      response.setEncoding( "utf8" )

      body = [ ]
      response.on "data", ( chunk ) -> body.push( chunk )

      response.on "end", () ->
        body_str = body.join ""

        if response.statusCode isnt 200
          error_details =
            status: response.statusCode,
            reason: response.headers[ 'x-mashery-error-code' ]
            body:   body_str

          callback error_details, null

        callback null, JSON.parse body_str

    req.end();

class exports.V1 extends Qwerly
  constructor: ( @api_key ) ->
    @domain      = "api.qwerly.com"
    @path_prefix = "/v1"

  path: ( extra ) ->
    @path_prefix + extra + "?api_key=" + @api_key

v1_apis =
  serviceApi:
    twitterUsername: "/twitter/%{s}.json"
    qwerlyUsername:  "/users/%{s}.json"
    facebookId:     "/facebook/%{s}.json"
  userApi:
    twitterUsername: "/twitter/%{s}/services.json"
    qwerlyUsername:  "/users/%{s}/services.json"
    facebookId:     "/facebook/%{s}/services.json"

# generate the api
for api, functions of v1_apis
  exports.V1.prototype[ api ] = () ->
    all = { }
    for name, path of functions
      do ( path ) =>
        all[ name ] = ( id, callback ) =>
          # is this going to be quick enough?
          id_path = path.replace /%\{s\}/g, id
          this.getter( id_path, callback )
    all
  true

q = new exports.V1 process.env.QWERLY_API_KEY
q.serviceApi().twitterUsername "philjackson", ( err, res ) ->
  console.log res