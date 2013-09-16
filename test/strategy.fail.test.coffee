chai = require 'chai'
Strategy = require '../src/strategy'

describe 'Strategy (fail)', ->

  secretKey = 'testSecretKey'
  signingString = 'testSigningString'

  strategy = new Strategy (req, done) ->
    done(null, { id: 1234 }, req.headers.signature, signingString, secretKey)

  describe 'should fail a request with a invalid signature', ->
    info = null

    before (done) ->
      chai.passport(strategy)
        .fail((i) ->
          info = i
          done()
        )
        .req((req) ->
          req.headers.signature = 'invalidSignatureTest'
        )
        .authenticate()

    it 'should supply signature mismatch message', ->
      info.should.be.a.object
      info.should.be.equal 'Signatures do not match'