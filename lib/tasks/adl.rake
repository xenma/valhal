namespace :adl do

  desc 'Import ADL files to Valhal'

  task :import, [:path] => :environment do |task, args|
    if (!Dir.exist?("#{args.path}"))
      raise "Directory #{args.path} does not exists"
    end

    Dir.glob("#{args.path}/texts/*.xml").each do |fname|
      puts "file #{fname}"
      doc = Nokogiri::XML(File.open(fname))

      id = doc.xpath("//xmlns:teiHeader/xmlns:fileDesc/xmlns:publicationStmt/xmlns:idno").text
      puts ("  ID is #{id}")

      sysno = id.split(":")[0]
      volno = id.split(":")[1]
      puts (" sysno #{sysno} vol #{volno}")

      doc.xpath("//xmlns:teiHeader/xmlns:fileDesc/xmlns:sourceDesc/xmlns:bibl/xmlns:title").each do |n|
        puts("  do something with title #{n.text}")
      end

      doc.xpath("//xmlns:teiHeader/xmlns:fileDesc/xmlns:sourceDesc/xmlns:bibl/xmlns:author").each do |n|
        puts("  do something with author #{n.xpath("//xmlns:forename").text} #{n.xpath("//xmlns:surname").text}")
      end
    end
  end
end