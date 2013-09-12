passport = require 'chai-passport-strategy'

chai = require 'chai'
chai.use passport

window.expect = chai.expect
