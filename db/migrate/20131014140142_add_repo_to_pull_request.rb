class AddRepoToPullRequest < ActiveRecord::Migration
  def change
    add_column :pull_requests, :repo_owner_login, :string
    add_column :pull_requests, :repo_name, :string
  end
end
