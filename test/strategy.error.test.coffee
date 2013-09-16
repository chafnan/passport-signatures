chai = require 'chai'
crypto = require 'crypto'
Strategy = require '../src/strategy'

describe 'Strategy (error)', ->

  strategy = new Strategy (req, done) ->
    done(new Error('Something wrong'))

  describe 'should handle a request with a valid signature', ->
    error = null

    before (done) ->
      chai.passport(strategy)
        .error((e) ->
          error = e
          done()
        )
        .req((req) ->
          req.headers.signature = 'fakeSignature'
        )
        .authenticate()

    it 'should error', ->
      error.should.be.an.instanceof Error
      error.message.should.be.equal 'Something wrong'