chai = require 'chai'
Strategy = require '../lib/strategy'

describe 'Strategy (fail)', ->

  secretKey = 'testSecretKey'
  signingString = 'testSigningString'

  describe 'should fail a request with a invalid signature', ->

    strategy = new Strategy (req, done) ->
      done(null, { id: 1234 }, req.headers.signature, signingString, secretKey)

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

  describe 'should fail a request and use options given', ->
    strategy = new Strategy (req, done) ->
      done(null, { id: 1234 }, req.headers.signature, signingString, secretKey)

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
        .authenticate(signatureMismatchMessage: 'Test mismatch message')

    it 'should supply custom signature mismatch message', ->
      info.should.be.a.object
      info.should.be.equal 'Test mismatch message'

  describe 'should fail if no user is passed', ->

    strategy = new Strategy (req, done) ->
      done(null, null, null, null, null, { message: 'Information Message' })

    info = null

    before (done) ->
      chai.passport(strategy)
        .fail((i) ->
          info = i
          done()
        )
        .authenticate()

    it 'should supply info message', ->
      info.should.be.a.object
      info.message.should.be.equal 'Information Message'