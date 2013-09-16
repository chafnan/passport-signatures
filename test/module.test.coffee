strategy = require '../src/index'

describe 'passport-signature', ->

  it 'should export Strategy constructor directly from package', ->
    strategy.should.be.a 'function'
    strategy.should.be.equal strategy.Strategy
  
  it 'should export Strategy constructor', ->
    strategy.Strategy.should.be.a 'function'