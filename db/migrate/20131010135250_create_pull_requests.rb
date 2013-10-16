class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.string :url
      t.string :html_url
      t.string :number
      t.string :title
      t.string :body
      t.datetime :merged_at

      t.timestamps
    end
  end
end
