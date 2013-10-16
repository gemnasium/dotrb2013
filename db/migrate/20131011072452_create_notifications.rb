class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :pull_request, index: true

      t.timestamps
    end
  end
end
