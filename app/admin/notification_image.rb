ActiveAdmin.register NotificationImage do
  menu label: "Notification Images"

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :photo do |notification_image|

      image_tag(notification_image.photo_url(:thumb))

    end
    column :created_at
    column :updated_at
    actions
  end

  filter :title

  form html: { multipart: true } do |f|
    f.semantic_errors
    f.inputs do
      f.input :facility_id, as: :select, collection: Facility.pluck(:organization_name, :id)
      f.input :title
      f.input :photo, :as => :file, :hint => f.object.photo.present? ? image_tag(f.object.photo_url(:thumb)):content_tag(:span, "no photo chosen yet")
      f.input :photo_cache, :as => :hidden
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :created_at
      row :updated_at
      row :photo do |notification_image|
        image_tag(notification_image.photo_url(:thumb))
      end
    end
  end
end