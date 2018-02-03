# ActiveAdmin.register Event do
#   permit_params :event_datetime, :user_id, :created_at, :updated_at, :name, :description, :photo
#   index do
#     selectable_column
#     id_column
#     column :event_datetime
#     column :name
#     column :user
#     column :created_at
#     column :updated_at
#     actions
#   end
#
#   filter :event_datetime
#   filter :name
#
#   form do |f|
#     f.semantic_errors
#     f.inputs do
#       f.input :name
#       f.input :event_datetime
#       f.input :description
#       f.input :photo
#       f.input :user_id, as: :select, collection: User.all.where(status: true)
#
#     end
#     f.actions
#   end
#
#   show do
#     attributes_table do
#       row :id
#       row :event_datetime
#       row :name
#       row :description
#       row :user
#       row :created_at
#       row :updated_at
#       row :photo do |event|
#         if event.photo.present?
#           link_to event.photo_url, target: '_blank' do
#             image_tag(event.photo_url(:thumb))
#           end
#         end
#       end
#     end
#   end
#
# end
