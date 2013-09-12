Strategy = require '../src/strategy'

chai = require 'chai'
should = chai.should()

describe 'Strategy', ->
    
  strategy = new Strategy -> {}
    
  it 'should be named anonymous', ->
    strategy.name.should.be.equal 'signature'
  
  describe 'handling a request', ->

    ok = null
    request = null

    before (done) ->
      chai.passport(strategy)
        .pass(->
          ok = true
          done()
        )
        .req((req) ->
          request = req
        )
        .authenticate()
    
    it 'should call pass', ->
      ok.should.be.true
    
    it 'should leave req.user undefined', ->
      should.not.exist request.user
