chai = require 'chai'
Strategy = require '../src/strategy'

describe 'Strategy', ->
    
  strategy = new Strategy(->)

  it 'should be named signature', ->
    strategy.name.should.be.equal 'signature'

  it 'should throw if constructed without a verify callback', ->
    (-> new Strategy()).should.throw 'SignatureStrategy requires a verify callback.'