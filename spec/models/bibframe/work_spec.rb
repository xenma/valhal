require 'spec_helper'

# Dummy class for testing
class Stub < ActiveFedora::Base
  include Bibframe::Work
end

describe Bibframe::Work do
  before :all do
    @stub = Stub.new
  end
  describe 'Datastreams:' do
    it 'should add Bibframe datastream' do
      expect(@stub.datastreams.keys).to include('bfMetadata')
    end
  end

  describe 'Literals:' do
    it 'should be possible to add a title' do
      @stub.add_title(value: 'The Importance of Being Earnest')
      expect(@stub.title_values).to include('The Importance of Being Earnest')
    end

    it 'should be possible to add a language with a part' do
      @stub.add_language(value: 'French', part: 'undefined')
      expect(@stub.language_values).to include 'French'
    end

    it 'should be possible to add a language without a part' do
      @stub.add_language(value: 'Gaeilge')
      expect(@stub.language_values).to include 'Gaeilge'
    end

    it 'should be possible to add an identifier' do
      @stub.add_identifier(scheme: 'kb', value: 'hoojabooja')
      expect(@stub.identifiers[:kb]).to eql 'hoojabooja'
    end
  end

  describe 'Relations:' do
    it 'has many Instances'
    it 'can be related to other works'
    it 'can be preceded by other works'
    it 'can be followed by other works'
    it 'can be part of an Instance'
  end
end
