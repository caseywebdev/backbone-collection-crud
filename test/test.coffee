should = require('chai').should()
Backbone = require 'backbone'
require '../'

describe 'save', ->
  it 'should exist on a new collection', ->
    Backbone.Collection::save.should.be.a.function
    (new Backbone.Collection).save.should.be.a.function

describe 'destroy', ->
  it 'should exist on a new collection', ->
    Backbone.Collection::destroy.should.be.a.function
    (new Backbone.Collection).destroy.should.be.a.function

