ActiveAdmin.register User do
  permit_params :name, :email, :officer_no, :phone_number, :status
  index do
    selectable_column
    id_column
    column :name
    column :email
    column  "Personal no ",:officer_no
    column :phone_number
    column :status
    column 'Set Status' do |user|
      if user.status
        link_to '', deactivate_admin_user_path(user),class:'glyphicon glyphicon-ban-circle text-danger ', title:'Unauthorize'
      else
        link_to '', approve_admin_user_path(user), class:'glyphicon glyphicon-ok-circle text-success', title:'Authorize'
      end
    end
    actions
  end


  filter :email
  filter :officer_no

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :email
      f.input :officer_no
      f.input :phone_number
      f.input :status
    end
    f.actions
  end

  member_action :approve do
    usr = User.friendly.find(params[:id])
    usr.status = true
    usr.save
    Delayed::Job.enqueue(UserAuthorizedMail.new(usr))
    redirect_to params[:dashboard].present? ? admin_dashboard_path : admin_users_path, notice: 'User authorized.'
  end

  member_action :deactivate do
    usr = User.friendly.find(params[:id])
    usr.status = false
    usr.save
    redirect_to params[:dashboard].present? ? admin_dashboard_path : admin_users_path, notice: 'User unauthorized.'
  end

  batch_action :email, form: {subject: :text, message:  :textarea},
               confirm: "Please enter the subject and the message below" do |ids, inputs|
     batch_action_collection.find(ids).each do |user|
      Delayed::Job.enqueue(BatchActionAdminMailSend.new(user,inputs, ids))
     end
    redirect_to collection_path, notice: "The email has been sent to all the users you selected."
  end



end
