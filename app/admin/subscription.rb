ActiveAdmin.register Subscription do
  filter :user # TODO string search using login
  filter :pull_request # TODO string search using alias

  index do
    column :id
    column :user
    column :pull_request
    column :created_at
    actions
  end

  show do |ad|
    attributes_table do
      row :id
      row :user
      row :pull_request
      row :created_at
    end
    active_admin_comments
  end
end
