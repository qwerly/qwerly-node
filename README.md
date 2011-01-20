Node Qwerly
===========

node-qwerly is an asynchronous node.js API for the
[Qwerly][qwerly.com] service.

Synopsis
--------

    Qwerly = qwerly.V1();
    q = new Qwerly(process.env.QWERLY_API_KEY);
    q.serviceApi().twitterUsername("philjackson", function(err, res) {
      return console.log(res);
    });
