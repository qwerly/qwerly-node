# Node Qwerly

node-qwerly is an asynchronous node.js API for the
[Qwerly][qwerly.com] service.

# Synopsis

    Qwerly = qwerly.V1();
    q = new Qwerly(process.env.QWERLY_API_KEY);
    q.services().viaTwitter("philjackson", function(err, res) {
      return console.log(res);
    });

# APIs

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