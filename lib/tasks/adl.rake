namespace :adl do

  desc 'Import ADL files to Valhal'

  task :import, [:path] => :environment do |task, args|
    if (!Dir.exist?("#{args.path}"))
      raise "Directory #{args.path} does not exists"
    end

    adl_activity = Administration::Activity.find('changeme:69')

    Dir.glob("#{args.path}/texts/*.xml").each do |fname|
      puts "file #{fname}"
      doc = Nokogiri::XML(File.open(fname))

      id = doc.xpath("//xmlns:teiHeader/xmlns:fileDesc/xmlns:publicationStmt/xmlns:idno").text
      unless id.blank?
        puts ("  ID is #{id}")

        sysno = id.split(":")[0]
        volno = id.split(":")[1]
        puts (" sysno #{sysno} vol #{volno}")

        i = nil
        i = find_instance(sysno) unless sysno == '000000000'
        i = create_new_work_and_instance(sysno,doc,adl_activity) if i.nil?
        add_contentfile_to_instance(fname,i)
      end
    end
  end


  private

  def find_instance(sysno)
    result = ActiveFedora::SolrService.query('system_number_tesim:"'+sysno+'" && active_fedora_model_ssi:Instance')
    if (result.size > 0)
      puts "  found instance #{result[0]['id']}"
      Instance.find(result[0]['id'])
    else
      puts "  no instance found"
      nil
    end
  end

  def create_new_work_and_instance(sysno,doc,adl_activity)
    w = Work.new
    doc.xpath("//xmlns:teiHeader/xmlns:fileDesc/xmlns:sourceDesc/xmlns:bibl/xmlns:title").each do |n|
      w.add_title(value: n.text)
    end

    doc.xpath("//xmlns:teiHeader/xmlns:fileDesc/xmlns:sourceDesc/xmlns:bibl/xmlns:author").each do |n|
      p = find_or_create_person(n.xpath("//xmlns:forename").text,n.xpath("//xmlns:surname").text)
      w.add_author(p)
    end
    w.save

    i = Instance.new
    i.set_work=w

    i.system_number = sysno
    i.activity = adl_activity.pid
    i.copyright = adl_activity.copyright
    i.collection = adl_activity.collection
    i.preservation_profile = adl_activity.preservation_profile
    i.save
    i
  end

  def add_contentfile_to_instance(fname,i)
    file = File.open(fname)
    i.add_file(file)
    i.save
  end

  def find_or_create_person(forename,surname)
    puts "  searching for person #{surname}, #{forename}"
    result = ActiveFedora::SolrService.query('person_name_tesim:"'+surname+', '+forename+'"')
    if (result.size > 0)
      puts "  found person #{result[0]['id']}"
      Authority::Person.find(result[0]['id'])
    else
      puts " creating person"
      p = Authority::Person.create(authorized_personal_name: { 'given' => forename, 'family' => surname})
      puts " person #{p.pid} created"
      p
    end
  end

end