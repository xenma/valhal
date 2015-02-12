require 'resque'

class SyncExtRepoADL
  @queue = 'sync_ext_repo'

  def self.perform(repo_id)
    repo = Administration::ExternalRepository[repo_id]
    repo.clear_sync_messages

    if repo.sync_status == 'NEW'
      success = SyncExtRepoADL.clone(repo)
    else
      success = SyncExtRepoADL.update(repo)
    end

    if (success)
      repo.sync_status = 'SUCCESS'
      repo.add_sync_message('Git update success')




    else
      repo.add_sync_message('Git update failed')
      repo.sync_status = 'FAILED'
    end




    repo.sync_date = DateTime.now.to_s
    repo.save
  end


  private

  def self.clone(repo)
    cmd = "git clone #{repo.url} /tmp/adl_data; cd /tmp/adl_data; git fetch; git checkout #{repo.branch}"
    system( cmd )
  end

  def self.update(repo)
    cmd = "cd /tmp/adl_data;git checkout #{repo.branch};git pull #{repo.url} /tmp/adl_data"
    system( cmd )
  end


end