
class BadRequestError extends Error

  constructor: (@message = null) ->
    console.log 'Error'
    console.log super
    super message
    Error.captureStackTrace(@, arguments.callee);
    @name = 'BadRequestError';

module.exports = BadRequestError;