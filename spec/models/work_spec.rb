require 'spec_helper'

describe Work do
  describe 'on creation' do
    it 'should have a uuid on creation' do
      w = Work.new
      expect(w.uuid).to be_nil
      w.save
      expect(w.uuid.present?).to be true
    end
  end

  describe 'Relations:' do

    it 'has many Instances'
    it 'can be part of an Instance'
    it 'can be related to other works'
    it 'can be preceded by other works'
    it 'can be followed by other works'
    it 'can have a printer'
  end
end
