ActiveAdmin.register AdminMessage do

  permit_params :subject, :content, :user_id

  index do
    selectable_column
    id_column
    column :subject
    column (:content) { |message| raw(message.content[0...100]) }
    column :created_at
    column :updated_at
    actions
  end

  filter :subject

  form do |f|
    div class: 'container' do
      f.semantic_errors
      f.inputs do
        f.input :subject
        f.input :user_id, as: :select,:collection => User.where(status:true).map{|u| ["#{u.name}", u.id]}, :hint => "Select User for send message individually otherwise message will be sent to all user "
        f.input :content, :input_html => { :rows =>10, :class => "tinymce" }
      end
      f.actions do
        f.submit as: :button, value: 'Send'
      end
    end
  end

  show do
    div class: 'container' do
      attributes_table do
        row :subject
        row (:content) { |message| raw(message.content) }
        row :created_at
        row :updated_at
      end
    end
  end


  controller do
    def new
      @admin_message = AdminMessage.new(user_id: params[:user_id])
    end
  end

end