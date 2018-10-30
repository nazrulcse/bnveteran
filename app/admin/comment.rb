ActiveAdmin.register Comment do
  permit_params :user_id, :comment, :commentable_type, :commentable_id, :title, :role, :comment_html

  index do
    selectable_column
    id_column
    column (:comment) { |message| raw(message.comment) }
    column :commentable
    column :user
    actions
  end

  filter :comment
  filter :created_at
  filter :updated_at

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :comment
    end
    f.actions
  end

    show do
      attributes_table do
        row :user
        row 'Post' do |comment|
          raw(comment.commentable.content)
        end
        row (:comment) { |message| raw(message.comment) }
        row :created_at
        row :updated_at
      end
    end


end