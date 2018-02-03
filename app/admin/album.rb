ActiveAdmin.register Album do
  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  filter :name

  form html: {multipart: true} do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.has_many :gallery_photos, heading: 'Gallery Photos' do |ff|
        ff.input :image, :as => :file, :hint => ff.object.image.present? ? image_tag(ff.object.image_url(:thumb)):content_tag(:span, "no photo chosen yet")
      end
    end
    f.actions
  end

  show do
    div class: 'container' do
      attributes_table do
        row :id
        row :name
        row :created_at
        row :updated_at
        row :gallery_photos do |album|
          ul do
            album.gallery_photos.each do |gallery_photo|
              div class: 'col-md-3 active-admin-attachment-show' do
                li do
                  span do
                    if gallery_photo.image.present?
                      link_to gallery_photo.image_url, target: '_blank' do
                        image_tag(gallery_photo.image_url(:thumb))
                      end
                    end
                  end
                  span do
                    link_to remove_gallery_photo_admin_album_path(album, image_id: gallery_photo.id), style: 'color: red; text-decoration: none; padding-left: 5px; font-size: 20px;', data: {confirm: 'Are you sure?'} do
                      raw '&#10006;'
                    end
                  end
                end
              end
            end
          end
          link_to 'Add More Gallery Photos', edit_admin_album_path(album), class: 'button'
        end
      end
    end
  end

  member_action :remove_gallery_photo do
    albm = Album.find_by_id(params[:id])
    gallery_photo = albm.gallery_photos.find_by_id(params[:image_id])
    gallery_photo.destroy if gallery_photo.present?
    redirect_to admin_album_path(albm), notice: 'Gallery photo removed'
  end
end