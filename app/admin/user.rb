ActiveAdmin.register User do
  permit_params :name, :rank, :email, :officer_no, :phone_number, :status, :password, :password_confirmation
  index do
    selectable_column
    id_column
    column :name
    column :email
    column "Personal no ", :officer_no
    column :phone_number
    column :status
    column 'Set Status' do |user|
      if user.status
        link_to '', deactivate_admin_user_path(user), class: 'glyphicon glyphicon-ban-circle text-danger ', title: 'Unauthorize'
      else
        link_to '', approve_admin_user_path(user), class: 'glyphicon glyphicon-ok-circle text-success', title: 'Authorize'
      end
    end

    column 'Message' do |user|
      link_to '', new_admin_admin_message_path(user_id: user.id), class: 'glyphicon glyphicon-envelope text-success ', title: 'Send Message'
    end
    actions
  end


  filter :email
  filter :officer_no, label: 'Official No / Personal No'

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :email
      f.input :rank, :label => 'Rank', :as => :select, :collection => User::RANK.collect { |name, id| [name, id] }
      f.input :officer_no
      f.input :phone_number
      f.input :status
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table_for user do
      row :name
      row :email
      row :encrypted_password
      row :about
      row :avatar do
        image_tag(user.avatar_url, width: 175) if user.avatar_url.present?
      end
      row :cover
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :confirmation_token
      row :confirmed_at
      row :confirmation_sent_at
      row :created_at
      row :updated_at
      row :sex
      row :location
      row :dob
      row :phone_number
      row :posts_count
      row :slug
      row :sash_id
      row :level
      row :designation_type
      row :rank do |user|
        flat_array = User::RANK.flatten
        rank_index = flat_array.index(user.rank)
        rank_index > 0 ? flat_array[rank_index - 1] : 'No Rank Specified'
      end
      row :officer_no
      row :date_joining
      row :date_retirement
      row :batch
      row :address
      row :state
      row :city
      row :country
      row :permanent_address
      row :present_address
      row :avatar_pdf
      row :present_state
      row :present_city
      row :present_country
      row :status
    end
  end

  member_action :approve do
    usr = User.friendly.find(params[:id])
    usr.status = true
    usr.save
    Delayed::Job.enqueue(UserAuthorizedMail.new(usr))
    redirect_to params[:dashboard].present? ? admin_dashboard_path : :back, notice: 'User authorized.'
  end

  member_action :deactivate do
    usr = User.friendly.find(params[:id])
    usr.status = false
    usr.save
    redirect_to params[:dashboard].present? ? admin_dashboard_path : :back, notice: 'User unauthorized.'
  end

  batch_action :email, form: {subject: :text, message: :textarea},
               confirm: "Please enter the subject and the message below" do |ids, inputs|
    batch_action_collection.find(ids).each do |user|
      Delayed::Job.enqueue(BatchActionAdminMailSend.new(user, inputs, ids))
    end
    redirect_to collection_path, notice: "The email has been sent to all the users you selected."
  end


end
