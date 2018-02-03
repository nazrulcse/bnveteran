ActiveAdmin.register AdminMessage do

  permit_params :subject, :content

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
        f.input :content, :input_html => { :rows =>10, :class => "tinymce" }
      end
      f.actions do
        f.submit as: :button, value: 'Send to All'
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


end