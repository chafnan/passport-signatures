chai = require 'chai'
Strategy = require '../lib/strategy'

describe 'Strategy', ->
    
  strategy = new Strategy(->)

  it 'should be named signature', ->
    strategy.name.should.be.equal 'signature'

  it 'should throw if constructed without a verify callback', ->
    (-> new Strategy()).should.throw 'SignatureStrategy requires a verify callback.'

  it 'should default options', ->
    actual = new Strategy {}, ->
    actual._algorithm.should.be.equal 'sha1'
    actual._encoding.should.be.equal 'base64'

  it 'should use set options', ->
    actual = new Strategy algorithm: 'testAlgorithm', encoding: 'testEncoding', ->
    actual._algorithm.should.be.equal 'testAlgorithm'
    actual._encoding.should.be.equal 'testEncoding'