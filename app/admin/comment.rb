ActiveAdmin.register Comment do
  permit_params :comment, :commentable, :user
end