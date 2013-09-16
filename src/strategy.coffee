crypto = require 'crypto'
passport = require 'passport-strategy'
util = require 'util'
BadRequestError = require './errors/BadRequestError'

###
 Creates an instance of `Strategy`.

 The signature authentication strategy passes authentication with verifying a
 calculated signature.

 This strategy can calculate the signature from the specified order of sources
 that can include anything in the request or headers.

 Examples:

     passport.use(new AnonymousStrategy());

 @constructor
 @api public
###

class Strategy extends passport.Strategy

  constructor: (@options, @verify) ->
    @verify = @options if typeof @options is 'function'
    throw new TypeError('SignatureStrategy requires a verify callback.') unless @verify

    @_algorithm = options.algorithm ? 'sha1'
    @_encoding = options.encoding ? 'base64'

    super @
    @name = 'signature'
    @_verify = @verify


  authenticate: (req, options) ->
    options ?= {}

    createSignature = (signingString, secretKey) =>
      digest = crypto.createHmac(@_algorithm, secretKey).update(signingString).digest @_encoding
      new Buffer(digest).toString @_encoding

    verified = (err, user, signature, signingString, secretKey, info) =>
      return @error(err) if err
      return @fail(info) unless user

      createdSignature = createSignature signingString, secretKey
      failMessage = options.signatureMismatchMessage ? 'Signatures do not match'
      return @fail(failMessage) if signature isnt createdSignature

      @success user, info

    @_verify req, verified
    return


module.exports = Strategy;
