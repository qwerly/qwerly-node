# Node Qwerly

node-qwerly is an asynchronous node.js API for the
[Qwerly](qwerly.com) service. It's written in Coffeescript but the JS
is included so no need for the Coffeescript compiler to use it.

# Synopsis

    Qwerly = qwerly.V1();
    q = new Qwerly(process.env.QWERLY_API_KEY);
    q.services().viaTwitter("philjackson", function(err, res) {
      return console.log(res);
    });

# APIs

Where $callback takes two functions. The first for an error and the
second for the resulting data structure which Qwerly gives us.

If there's an error then $err will contain an object which looks like
this:

    status: HTTP status code
    reason: x-mashery-error-code header value
    body:   body (as a string)

## Service lookups

        qwerly.services().viaTwitter( $id, $callback )
        qwerly.services().viaQwerly( $id, $callback )
        qwerly.services().viaFacebook( $id, $callback )

## User lookups

        qwerly.users().viaTwitter( $id, $callback )
        qwerly.users().viaQwerly( $id, $callback )
        qwerly.users().viaFacebook( $id, $callback )

# TODO

An asynchronous 202 polling interface for delayed lookups.