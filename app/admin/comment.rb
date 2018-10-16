ActiveAdmin.register Comment do
  permit_params :user_id, :comment, :commentable_type, :commentable_id, :title, :role, :comment_html

  index do
    selectable_column
    id_column
    column :title
    column (:comment) { |message| raw(message.comment) }
    column :commentable_type
    column :user_id
    actions
  end


end