require 'spec_helper'

describe Instance do
  it 'has many files' do
    i = Instance.new
    expect(i.content_files.size).to eql 0
  end
end
