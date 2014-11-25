module Datastreams
  
  module TransWalker 

    def from_mods(mods)
      @mods = mods

      if(self.is_a? Instance) then
        self.to_instance(@mods)
      elsif(self.is_a? Work) then
        self.to_work(@mods)
      else
        fail "Neither Work nor Instance"
      end
    end

    def to_work(mods)
      tit = {
        value: mods.title.first,
        subtitle: mods.subTitle.first,
        lang: ''
      }
      
      self.add_title(tit)
      mods.person.each { |p|
        p = p.chomp ? p : p.strip
        name={authorized_personal_name: { full: p, scheme: 'KB' }}
        mads=Authority::Person.create(name)
        self.add_author(mads)
      }
    end

    def to_instance(mods)


      self.note=mods.note

      # self.note
      # self.identifier 
      # self.Identifier

      # self.language
      # self.mode_of_issuance(path: 'modeOfIssuance')
      # self.title_statement(path: 'titleStatement', index_as: :stored_searchable)
    
      self.extent=mods.physicalExtent.first 

      # self.dimensions
      # self.contents_note(path: 'contentsNote')
      # self.isbn13(proxy: [:isbn_13, :Identifier, :label])

      self.isbn13=mods.isbn.first

      #
      # self.publication 
      # self.Provider 
      # self.copyrightDate
      # self.providerDate

      # publication There is hardly any way we can distinguish between a
      # copyright date and a date of issuance, or is there?

      # self.copyright_date(proxy: [:publication, :Provider, :copyrightDate])

      # Don't know what happens if these are repeated.

      self.published_date  = mods.dateIssued.first
      self.publisher_name  = mods.publisher.first
      self.published_place = mods.originPlace.first
    end

    
  end
end
