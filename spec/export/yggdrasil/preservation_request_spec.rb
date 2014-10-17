require 'spec_helper'

describe 'Invalid PreservationRequest' do

  it 'raises ArgumentError for invalid preservation profile' do
    expect {Yggdrasil::PreservationRequest.new('invalid', 'test comment', 'true') }.to raise_error(ArgumentError)
  end

  it 'raises ArgumentError for invalid preservation commit value' do
    expect {Yggdrasil::PreservationRequest.new('simple', 'test comment', 'tralse') }.to raise_error(ArgumentError)
  end
end