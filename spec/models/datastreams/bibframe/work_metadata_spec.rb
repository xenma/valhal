require 'spec_helper'

describe Datastreams::Bibframe::WorkMetadata do
  before :all do
    file = File.new('./spec/fixtures/gutenberg.xml')
    @ds = Datastreams::Bibframe::WorkMetadata.from_xml(file)
  end

  describe 'titles' do
    it 'returns an array of title objects' do
      expect(@ds.titles).to be_an Array
      expect(@ds.titles.first).to be_a Datastreams::Bibframe::Title
    end

    it 'has a titleType for each title object' do
      expect(@ds.titles.first.type).to eql 'uniform'
    end

    it 'has a subtitle for each title object' do
      expect(@ds.titles.first.subtitle).to eql 'Heroes * Villains * Towers * Punishment!'
    end

    it 'has an array of values for each title object' do
      expect(@ds.titles.first.values).to be_an Array
      expect(@ds.titles.first.values.first).to be_a Datastreams::Bibframe::Title::TitleValue
    end

    it 'has a value for each title value' do
      expect(@ds.titles.first.values.first.value).to eql 'Gutenberg Bible'
    end

    it 'has a lang for each title value' do
      expect(@ds.titles.first.values.first.lang).to eql 'en'
    end

    it 'allows us to write a title' do
      ds = Datastreams::Bibframe::WorkMetadata.new
      ds.add_title(type: 'uniform', subtitle: 'and so on...', lang: 'en', value: 'Great Expectations')
      expect(ds.titles.first.subtitle).to eql 'and so on...'
      expect(ds.titles.first.type).to eql 'uniform'
      expect(ds.titles.first.values.first.value).to eql 'Great Expectations'
      expect(ds.titles.first.values.first.lang).to eql 'en'
    end
  end

  it 'parses a note' do
    expect(@ds.note)
    .to eql ['Mode of access: World Wide Web.']
  end

  it 'parses the language' do
    expect(@ds.language).to eql ['eng']
  end

  it 'parses the language authority' do
    expect(@ds.language_authority)
    .to eql ['http://id.loc.gov/vocabulary/languages.html']
  end

  it 'parses the uuid' do
    expect(@ds.uuid).to eql 'reallyrandomuuid'
  end

  it 'allows us to write a uuid' do
    ds = Datastreams::Bibframe::WorkMetadata.new
    ds.uuid = 'anotherrandomuuid'
    expect(ds.uuid).to eql 'anotherrandomuuid'
  end
end
