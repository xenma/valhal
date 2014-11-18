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
      name =  { full: "And, Anders", scheme: 'KB' }
      mads = Authority::Person.new(authorized_personal_name: name)
      tit = {value: 'The Unbearable Lightness of Being', 
          subtitle: '',
              type: 'KB',
              lang: 'en'}
      self.add_title(tit)
      self.add_author(mads)
    end

    def to_instance(mods)

    end

    
  end
end
