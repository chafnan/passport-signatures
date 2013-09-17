BadRequestError = require '../lib/errors/BadRequestError'

expectedMessage = 'Bad Request Error Message'
error = new BadRequestError expectedMessage
errorNoMessage = new BadRequestError()

describe 'BadRequestError', ->

  it 'should supply a name', ->
    error.name.should.be.equal 'BadRequestError'

  it 'should supply message', ->
    error.message.should.be.equal expectedMessage

  it 'should by typeof Error', ->
    error.should.be.instanceof Error

  it 'should allow a null message', ->
    should.not.exist errorNoMessage.message
