ActiveAdmin.register PullRequest do
  filter :number
  filter :title
  filter :body

  index do
    column :id
    column :repo_owner_login
    column :repo_name
    column :number do |pull_request|
      link_to pull_request.number, pull_request.html_url
    end
    column :title
    actions
  end

  show do |ad|
    attributes_table do
      row :id
      row :url do |pull|
        link_to pull.url, pull.url
      end
      row :html_url do |pull|
        link_to pull.html_url, pull.html_url
      end
      row :repo_owner_login
      row :repo_name
      row :number
      row :title
      row :body
      row :merged_at
    end
    active_admin_comments
  end
end
