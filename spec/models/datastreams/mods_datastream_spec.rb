# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'personal name' do

  it 'should retrieve the personal names ' do
    f = File.new(Rails.root.join('spec', 'fixtures', 'mods_digitized_book_with_2_authors.xml'))
    mods = Datastreams::Mods.from_xml(f)
    expect(mods.person.name).to eql ['Klee, Frederik', 'Laudrup, Henrik']
  end

  it 'should not mistake subject persons as author ones ' do
    f = File.new(Rails.root.join('spec', 'fixtures', 'mods_with_subject_person.xml'))
    mods = Datastreams::Mods.from_xml(f)
    expect(mods.agentPerson).not_to include ['Darwin, Charles']
    puts mods.agentPerson
  end

  it 'should retrieve the corporate names ' do
    f = File.new(Rails.root.join('spec', 'fixtures', 'mods_digitised_corp_author.xml'))
    mods = Datastreams::Mods.from_xml(f)
    expect(mods.corporate.name).to eql ['Børnehjemmet "Godthaab"']
  end

  it 'should retrieve the primary name' do
    f = File.new(Rails.root.join('spec', 'fixtures', 'mods_digitized_book_with_2_authors.xml'))
    mods = Datastreams::Mods.from_xml(f)
    expect(mods.primary.name).to eql ['Klee, Frederik']
  end

  it 'should retrieve the author from a record from aleph' do
    @service = AlephService.new
    set = @service.find_set("isbn=9788711396322") 
    rec = @service.get_record(set[:set_num],set[:num_entries])
    @converter = ConversionService.new(rec)
    doc = @converter.to_mods("")
    mods = Datastreams::Mods.from_xml(doc)
    expect(mods.primary.name).to eql ['Knausgård, Karl Ove']
  end

end
