require 'resque'

class SyncExtRepoADL
  @queue = 'sync_ext_repo'

  def self.perform(repo_id)
    repo = Administration::ExternalRepository[repo_id]

    repo.sync_status = 'FAILED'
    repo.sync_date = DateTime.now.to_s

    repo.add_sync_message('ADL Sync not implemented yet')
    repo.save
  end
end