require 'spec_helper'

# Dummy class for testing
class Stub < ActiveFedora::Base
  include Bibframe::Instance
end

describe Bibframe::Instance do
  before :all do
    @stub = Stub.new
  end

  describe 'on include' do
    it 'fails when included from a non AF class' do
      expect {
        # doesn't extend AF::Base
        class StubNoAF; include Bibframe::Instance; end
      }.to raise_error(RuntimeError)
    end

    it 'does not fail when included from an AF descendant' do
      expect { class Desc < Stub; end }.not_to raise_error
    end
  end

  describe 'literals' do
    it 'should allow us to set and get notes' do
      @stub.note = ['a note']
      expect(@stub.note).to eql ['a note']
    end

    it 'should allow us to set and get a copyright date' do
      @stub.copyright_date = '19-02-2012'
      expect(@stub.copyright_date).to eql '19-02-2012'
    end

    it 'should allow us to set and get isbn13' do
      @stub.isbn13 = '9780521169004'
      expect(@stub.isbn13).to eql '9780521169004'
    end

    it 'should allow us to set and get a mode of issuance' do
      @stub.mode_of_issuance = 'printed'
      expect(@stub.mode_of_issuance).to eql 'printed'
    end

    it 'should allow us to set and get a title statement' do
      @stub.title_statement = 'Published in Rome'
      expect(@stub.title_statement).to eql 'Published in Rome'
    end

    it 'should allow us to set and get an extent' do
      @stub.extent = 'incomplete'
      expect(@stub.extent).to eql 'incomplete'
    end

    it 'should allow us to set and get dimensions' do
      @stub.dimensions = '36cm'
      expect(@stub.dimensions).to eql '36cm'
    end

    it 'should allow us to set and get a uuid' do
      @stub.uuid = 'veryrandomuuid'
      expect(@stub.uuid).to eql 'veryrandomuuid'
    end

  end

  describe 'relations' do
    it 'is an instance of a work'
    it 'can have parts which are Works'
  end
end
