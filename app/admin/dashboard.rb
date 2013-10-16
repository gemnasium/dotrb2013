ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recently merged Pull Requests" do
          ul do
            PullRequest.not_merged.order("merged_at DESC").limit(10).map do |pull_request|
              li link_to(pull_request.short_name, admin_pull_request_path(pull_request))
            end
          end
        end
      end

      column do
        panel "Recently created Users" do
          ul do
            User.order("created_at DESC").limit(10).map do |user|
              li link_to(user.login, admin_user_path(user))
            end
          end
        end
      end
    end
  end
end
