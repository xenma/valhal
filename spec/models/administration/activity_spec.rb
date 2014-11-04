# -*- encoding : UTF-8 -*-
require 'spec_helper'

describe Administration::Activity do

  it_behaves_like 'ActiveModel'

  it 'should have a name' do
    act = Administration::Activity.new
    act.name = 'my first controlled list'
    expect(act.name).to eql 'my first controlled list'
  end

end
