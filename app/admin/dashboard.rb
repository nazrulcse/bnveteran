ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") }, class: 'container' do
    div class: 'container' do
      div class: "blank_slate_container", id: "dashboard_default_message" do
        #   span class: "blank_slate" do
        #     span I18n.t("active_admin.dashboard_welcome.welcome")
        #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
        #   end
      end
    end

    div class: 'container' do

      div :class => 'tabs' do

        ul :class => 'nav nav-tabs', :role=> 'tablist' do
          li { link_to 'All Users', '#all', :class =>'active', :style=>'color:black; font:bold; font-size:20px;' }
          li { link_to 'Active Now', '#active_now', :style=>'color:black; font:bold; font-size:20px;' }
        end

        div :class => 'tab-content' do

          div :id => 'all' do
            section " All Users", :style=>'color:black; font:bold;' do
              idx = 0
              table_for User.all, class: 'container table table-responsive table-hover table-condensed' do |t|
                t.column("Serial No") { idx += 1 }
                t.column("Name") { |user| user.name }
                t.column("Email") { |user| user.email }
                t.column("Status") { |user| user.status }
                t.column("Set Status") do |user|
                  if user.status
                    link_to '', deactivate_admin_user_path(user, dashboard: 'yes'),class:'glyphicon glyphicon-ban-circle text-danger ', title:'Unauthorize'
                  else
                    link_to '', approve_admin_user_path(user, dashboard: 'yes'), class:'glyphicon glyphicon-ok-circle text-success', title:'Authorize'
                  end
                end
              end
            end
          end

          div :id => 'active_now', :style=>'display:none;' do
            section " Active Now", :style=>'color:black; font:bold;' do
              idx = 0
              table_for User.all.collect{|u| u if u.online? }.compact, class: 'container table table-responsive table-hover table-condensed' do |t|
                t.column("Serial No") { idx += 1 }
                t.column("Name") { |user| user.name }
                t.column("Email") { |user| user.email }
                t.column("Status") { |user| user.status }
                t.column("Set Status") do |user|
                  if user.status
                    link_to '', deactivate_admin_user_path(user, dashboard: 'yes'),class:'glyphicon glyphicon-ban-circle text-danger ', title:'Unauthorize'
                  else
                    link_to '', approve_admin_user_path(user, dashboard: 'yes'), class:'glyphicon glyphicon-ok-circle text-success', title:'Authorize'
                  end
                end
              end
            end
          end

        end
      end

    end # content

  end
end
