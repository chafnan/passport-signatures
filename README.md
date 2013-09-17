# passport-signatures

[![Build Status](https://travis-ci.org/chafnan/passport-signatures.png?branch=master)](https://travis-ci.org/chafnan/passport-signatures)
[![Coverage Status](https://coveralls.io/repos/chafnan/passport-signatures/badge.png?branch=master)](https://coveralls.io/r/chafnan/passport-signatures?branch=master)
[![Dependency Status](https://david-dm.org/chafnan/passport-signatures.png)](https://david-dm.org/chafnan/passport-signatures)

[Passport](http://passportjs.org/) strategy for signature authentication.

This module lets you provide signature authentication in your Node.js
applications.  By plugging into Passport, signature authentication can
be easily and unobtrusively integrated into any application or framework
that supports [Connect](http://www.senchalabs.org/connect/)-style middleware
, including [Express](http://expressjs.com/).

## Install

    $ npm install passport-signatures

## About Strategy

The signature authentication strategy authenticates using a calculated
signature. In this strategy the request sent will include a signature from
specified data that is encryted with a `secret key`.  The server will verify
the signature by recreating the signatue on the server side and matching it
to the request signature.  This is the same method used by the
[Amazon Web Services Signing Process](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).

The data that is encrypted should include various data points that is
available to the client and that sent through the request and data the
server knows about the client.  This can include data from the headers, HTTP
Method, Client IP Address, the request body, etc.  The important not to make
is that the server needs recreate the signature that is created to verify
the signature sent by the client.

## Usage

#### Configure Strategy

The signature and public key can be passed through any method that you choose
. In this example, they are being passed through the header.  To see this
example live check out in the [signature example](https://github.com/chafnan/passport-signatures/tree/master/examples/signature).

``` Javascript
passport.use(new SignatureStrategy({}, function(req, done) {
    User.findByPublicKey(req.headers.publickey, function(err, user) {
      var signingString;
      if (err) { return done(err); }
      if (!user) { return done(null, false); }
      signingString = req.method + "\n" + req.headers.publickey;
      return done(null, user, req.headers.signature, signingString, user.secretKey);
    });
  }));
```

#### Authenticate Requests

Use `passport.authenticate()`, specifying the `'signature'` strategy, to
pass authentication of a request.  Requests do not require session support,
so the `session` option can be set to `false`.

For example, as route middleware in an [Express](http://expressjs.com/)
application:

``` Javascript
passport.authenticate('signature', { session: false })
```

## Examples

For a complete, working example, refer to the [example](https://github.com/chafnan/passport-anonymous/tree/master/examples/signature).

## Tests

    $ npm install
    $ npm test

## Credits

  - [Jonathan Chapman](http://github.com/chafnan)

## License

[The MIT License](http://opensource.org/licenses/MIT)

Copyright (c) 2013 Jonathan Chapman <[http://github.com/chafnan](http://github.com/chafnan)>