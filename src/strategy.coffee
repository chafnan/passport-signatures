passport = require('passport-strategy')
util = require('util');

###
 Creates an instance of `Strategy`.

 The anonymous authentication strategy passes authentication without verifying
 credentials.

 Applications typically use this as a fallback on endpoints that can respond
 to both authenticated and unauthenticated requests.  If credentials are not
 supplied, this stategy passes authentication while leaving `req.user` set to
 `undefined`, allowing the route to handle unauthenticated requests as
 desired.

 Examples:

     passport.use(new AnonymousStrategy());

 @constructor
 @api public
###
class Strategy extends passport.Strategy

  constructor: ->
    @name = 'signature'

  authenticate: ->
    @pass()


module.exports = Strategy;
