module Datastreams
  
  module TransWalker 

    def from_mods(mods)
      @mods = mods
      if(self.class.name =~ /Instance/) then
        self.to_instance(@mods)
      elsif(self.class.name =~ /Work/) then
        self.to_work(@mods)
      else
        fail "Neither Work nor Instance"
      end
    end

    def to_work(mods)
      tit = {value: mods.title.first,
          subtitle: mods.subTitle.first,
              type: 'KB',
              lang: 'da'}
      self.add_title(tit)
      mods.person.each { |p|
        p = p.chomp ? p : p.strip
        name={authorized_personal_name: { full: p, scheme: 'KB' }}
        mads=Authority::Person.create(name)
        self.add_author(mads)
      }
    end

    def to_instance(mods)
      # self.note
      # self.identifier 
      # self.Identifier

      # self.publication 
      # self.Provider 
      # self.copyrightDate
      # self.providerDate


      # self.language
      # self.mode_of_issuance(path: 'modeOfIssuance')
      # self.title_statement(path: 'titleStatement', index_as: :stored_searchable)
    
      self.extent=mods.physicalExtent.first 

      # self.dimensions
      # self.contents_note(path: 'contentsNote')
      # self.isbn13(proxy: [:isbn_13, :Identifier, :label])

      self.isbn13=mods.isbn.first

      # self.copyright_date(proxy: [:publication, :Provider, :copyrightDate])
      # self.published_date(proxy: [:publication, :Provider, :providerDate])
    end

    
  end
end
