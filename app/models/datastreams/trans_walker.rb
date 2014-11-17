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
      
    end

    def to_instance(mods)

    end

    
  end
end
