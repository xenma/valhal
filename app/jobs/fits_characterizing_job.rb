require 'resque'

class FitsCharaterizingJob

  @queue = 'fits_characterizing'

  # Perform fits characterizing of a contentfile
  # @param pid : pid of the contentfile to be characterized
  def self.perform(pid)
    cf = ContentFile.find(pid)
    tmpfile = Tempfile.new(cf.original_filename)
    tmpfile.write(cf.datastreams['content'].content)
    tmpfile.rewind
    cf.add_fits_metadatastream(tmpfile)
    tmpfile.close
  end
end