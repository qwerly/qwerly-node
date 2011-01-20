Qwerly = require( "../lib/qwerly" ).V1

done = ( t, count ) ->
  if count and count > 0
    actual = t._assertion_list.length

    if actual < count
      setTimeout( done, 20, t, count )
    else if actual > count
      throw new Error "Ran #{actual} which is more than #{count}."
    else
      t.done()

exports.basic = ( t ) ->
  t.ok process.env.QWERLY_API_KEY
  t.ok q = new Qwerly process.env.QWERLY_API_KEY

  t.ok q.serviceApi instanceof Function
  t.ok q.userApi instanceof Function

  done( t, 4 )

# TODO: actually something
exports[ "user API" ] = ( t ) ->
  t.ok process.env.QWERLY_API_KEY
  t.ok q = new Qwerly process.env.QWERLY_API_KEY

  expected =
    description: 'iPlayer developer @ BBC. Lead developer of Emacs Magit.'
    name: 'Phil Jackson'
    twitter_username: 'philjackson'
    website: 'http://www.shellarchive.co.uk'
    qwerly_username: 'philjackson'

  done( t, 2 )

exports[ "service API" ] = ( t ) ->
  t.ok process.env.QWERLY_API_KEY
  t.ok q = new Qwerly process.env.QWERLY_API_KEY

  expected =
    flickr:
      url: "http://www.flickr.com/photos/phil-jackson/"
      username: "phil-jackson"
    foursquare:
      url: "http://foursquare.com/user/philjackson"
      username: "philjackson"
    friendfeed:
      url: "http://friendfeed.com/philjackson1"
      username: "philjackson1"
    github:
      url: "http://github.com/philjackson"
      username: "philjackson"
    plancast:
      url: "http://plancast.com/philjackson"
      username: "philjackson"
    twitter:
      url: "http://twitter.com/philjackson"
      username: "philjackson"
    klout:
      url: "http://klout.com/philjackson"
      username: "philjackson"

  q.serviceApi().viaTwitter "philjackson", ( err, res ) ->
    t.equal null, err
    t.equal 200, res.status

    for service in res.services
      t.equal expected[ service.type ].url, service.url
      t.equal expected[ service.type ].username, service.username

    done( t, 20 )
