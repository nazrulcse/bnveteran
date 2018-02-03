ActiveAdmin.register GalleryPhoto do
  menu label: "Gallery"

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    #column :album
    column :image do |gallery_photo|
      link_to gallery_photo.image_url, target: '_blank' do
        image_tag(gallery_photo.image_url(:thumb))
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :album_id

  form html: { multipart: true } do |f|
    f.semantic_errors
    f.inputs do
      f.input :album_id, as: :select, collection: Album.all
      f.input :image#, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :album
      row :created_at
      row :updated_at
      row :image do |gallery_photo|
        link_to gallery_photo.image_url, target: '_blank' do
          image_tag(gallery_photo.image_url(:thumb))
        end
      end
    end
  end
end