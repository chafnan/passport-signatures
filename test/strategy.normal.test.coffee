chai = require 'chai'
crypto = require 'crypto'
Strategy = require '../src/strategy'

describe 'Strategy (normal)', ->

  secretKey = 'testSecretKey'
  signingString = 'testSigningString'

  strategy = new Strategy (req, done) ->
    done(null, { id: 1234 }, req.headers.signature, signingString, secretKey, { message: 'Test Message' })

  describe 'should handle a request with a valid signature', ->
    user = null
    info = null

    before (done) ->
      chai.passport(strategy)
        .success((u, i) ->
          user = u
          info = i
          done()
        )
        .req((req) ->
          digest = crypto.createHmac('sha1', secretKey).update(signingString).digest 'base64'
          req.headers.signature = new Buffer(digest).toString 'base64'
        )
        .authenticate()

    it 'should supply a user', ->
      user.should.be.a.object
      user.id.should.be.equal 1234

    it 'should supply an info', ->
      info.should.be.a.object
      info.message.should.be.equal 'Test Message'