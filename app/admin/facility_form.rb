ActiveAdmin.register FacilityForm do
  menu label: "Forms"
  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :form do |facility_form|
      link_to facility_form.form_url, target: '_blank' do
        if facility_form.form_url(:medium_thumb_pdf)
          image_tag(facility_form.form_url(:medium_thumb_pdf))
        else
          i class:"fa fa-file-pdf-o", aria_hidden: "true", style: 'font-size: 80px !important ;'
        end
      end
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
			if f.object.form && f.object.form_url(:medium_thumb_pdf).present?
        f.input :form, :as => :file, :hint =>  image_tag(f.object.form_url(:medium_thumb_pdf))
			else
        f.input :form, :as => :file, :hint => f.object.form.present? ? i( class:"fa fa-file-pdf-o", aria_hidden: "true", style: 'font-size: 80px !important ;') : content_tag(:span, "no form chosen yet")
      end

      f.input :form_cache, :as => :hidden
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :created_at
      row :updated_at
      row :form do |facility_form|
        link_to facility_form.form_url, target: '_blank' do
          if facility_form.form_url(:medium_thumb_pdf)
            image_tag(facility_form.form_url(:medium_thumb_pdf))
          else
            i class:"fa fa-file-pdf-o", aria_hidden: "true", style: 'font-size: 80px !important ;'
          end
        end
      end
    end
  end
end