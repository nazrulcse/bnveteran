# ActiveAdmin.register MenuBarItem do
#   actions :all, :except => [:new, :destroy]
#
#   controller do
#     def permitted_params
#       params.permit!
#     end
#   end
#
#   index do
#     selectable_column
#     id_column
#     column :name
#     column :created_at
#     column :updated_at
#     actions
#   end
#
#   filter :name
#
#   form do |f|
#     f.semantic_errors
#     f.inputs do
#       h5(style: 'margin-left: 10px;') do
#         "Name:  #{f.object.name}"
#       end
#       f.has_many :page_banners, heading: 'Facility Forms' do |ff|
#         ff.input :banner_photo
#       end
#     end
#     f.actions
#   end
#
#   show do
#     attributes_table do
#       row :id
#       row :name
#       row :created_at
#       row :updated_at
#       row :page_banners do |menu_bar_item|
#         ul do
#           menu_bar_item.page_banners.each do |page_banner|
#             li do
#               span do
#                 if page_banner.banner_photo.present?
#                   link_to page_banner.banner_photo_url, target: '_blank' do
#                     image_tag(page_banner.banner_photo_url(:thumb))
#                   end
#                 end
#               end
#               span do
#                 link_to remove_banner_image_admin_menu_bar_item_path(menu_bar_item, banner_image_id: page_banner.id), style: 'color: red; text-decoration: none; padding-left: 5px; font-size: 20px;', data: {confirm: 'Are you sure?'} do
#                   raw '&#10006;'
#                 end
#               end
#             end
#           end
#         end
#       end
#     end
#   end
#
#   member_action :remove_banner_image do
#     menu_item = MenuBarItem.find_by_id(params[:id])
#     banner_image = menu_item.page_banners.find_by_id(params[:banner_image_id])
#     banner_image.destroy if banner_image.present?
#     redirect_to admin_menu_bar_item_path(menu_item), notice: 'Page banner removed'
#   end
# end