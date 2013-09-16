passport = require 'chai-passport-strategy'

chai = require 'chai'
chai.use passport

global.expect = chai.expect
global.should = chai.should()