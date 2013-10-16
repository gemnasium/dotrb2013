ActiveAdmin.register User do
  filter :login
  filter :email

  index do
    column :id
    column :login
    column :email
    column :created_at
    actions
  end
end
