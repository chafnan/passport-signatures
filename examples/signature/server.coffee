express = require 'express'
http = require 'http'
path = require 'path'
passport = require 'passport'
SignatureStrategy = require 'passport-signatures'

users = [
  { id: 1, username: 'bob', publicKey: 'bobPublicKey', secretKey: 'bobSecretKey', email: 'bob@example.com' }
  { id: 2, username: 'joe', publicKey: 'joePublicKey', secretKey: 'bobSecretKey', email: 'joe@example.com' }
]

findByPublicKey = (publicKey, fn) ->
  return fn(null, user) for user in users when user.publicKey is publicKey
  return fn(null, null)

app = express()

# Configure passport-signatures
passport.use new SignatureStrategy {}, (req, done) ->
  findByPublicKey req.headers.publickey, (err, user) ->
    return done(err) if err
    return done(null, false) unless user

    # This can be anything that you choose to use. Just make sure it
    # is the same tha client is using to generate signature.
    signingString =
      """
      #{req.method}
      #{req.headers.publickey}
      """

    # The signature can come from other places then the header.
    # It's all about how you want to pass the signature.
    done(null, user, req.headers.signature, signingString, user.secretKey)

# Configure express
app.use express.logger()
app.use passport.initialize()
app.use app.router
app.use express.static(path.join(__dirname, 'app'))

app.listen process.env.PORT || 3000, ->
  console.log "Express server listening on port #{process.env.PORT || 3000}"


# Test Examples
# curl -v -H 'publickey: bobPublicKey' -H 'signature: VFhZVE5VRC91YTNRR3RXaFhoKzRGckJJYmJZPQ==' http://localhost:3000/
# curl -v -H 'publickey: joePublicKey' -H 'signature: RVUxSTcxVTlkYUhIcVMyRnNLeXQyY1pOdFZzPQ==' http://localhost:3000/
app.get '/', passport.authenticate('signature', { session: false }), (req, res) ->
  res.json
    username: req.user.username
    email: req.user.email
