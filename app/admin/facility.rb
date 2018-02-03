ActiveAdmin.register Facility do
  #actions :all, :except => [:edit]


  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    column "Facility Name",:organization_name
    column :created_at
    column :updated_at
    actions
  end

  filter :organization_name
  filter :form_title

  form html: {multipart: true} do |f|
    div class: 'container' do
      f.semantic_errors
      f.inputs do
        f.input :organization_name
        f.input :organization_logo
        f.input :description, :input_html => { :rows =>10, :class => "tinymce" }
        # div class: 'col-md-6' do
        #   f.has_many :facility_forms, heading: 'Facility Forms' do |ff|
        #     ff.input :title
        #     ff.input :form, :as => :file, :hint => ff.object.form.present? ? image_tag(ff.object.form_url(:medium_thumb_pdf)):content_tag(:span, "no form chosen yet")
        #     ff.input :form_cache, :as => :hidden
        #
        #   end
        # end
        # div class: 'col-md-6' do
        #   f.has_many :notification_images, heading: 'Notification Images' do |ff|
        #     ff.input :photo, :as => :file, :hint => ff.object.photo.present? ? image_tag(ff.object.photo_url(:thumb)):content_tag(:span, "no photo chosen yet")
        #     ff.input :photo_cache, :as => :hidden
        #   end
        #
        # end
      end
      f.actions
    end
  end

  show do
    div class: 'container' do
      attributes_table do
        row :id
        row :organization_name
        row :organization_logo do |facility|
          if facility.organization_logo.present?
            link_to facility.organization_logo_url, target: '_blank' do
              image_tag(facility.organization_logo_url(:thumb))
            end
          end
        end
        row :description do |facility|
          raw facility.description
        end
        row :created_at
        row :updated_at
        row :form_title
        row :facility_forms do |facility|
          ul do
            facility.facility_forms.each do |facility_form|
              div class: 'col-md-3 active-admin-attachment-show' do
                li do
                  h4 do
                    facility_form.title
                  end
                  if facility_form.form.present?
                    span do
                      link_to facility_form.form_url, target: '_blank' do
                        image_tag(facility_form.form_url(:medium_thumb_pdf))
                      end
                    end

                    span do
                      link_to remove_facility_form_admin_facility_path(facility_id: facility, facility_form_id: facility_form.id), style: 'color: red; text-decoration: none; padding-left: 5px; font-size: 20px;', data: {confirm: 'Are you sure?'} do
                        raw '&#10006;'
                      end
                    end

                  end
                end
              end
            end
          end
          ul do
            div class: 'col-md-3 active-admin-attachment-show' do
              li do
                link_to 'Add More', new_admin_facility_form_path, class: 'btn btn-primary'
              end
            end
          end
        end
        row :notification_images do |facility|
          ul do
            facility.notification_images.each do |notification_image|
              div class: 'col-md-3 active-admin-attachment-show' do
                li do
                  span do
                    if notification_image.photo.present?
                      if notification_image.photo.path.downcase.end_with?('.pdf')
                        link_to notification_image.photo_url, target: '_blank' do
                          image_tag(notification_image.photo_url(:medium_thumb_pdf))
                        end
                      else
                        link_to notification_image.photo_url, target: '_blank' do
                          image_tag(notification_image.photo_url(:thumb))
                        end
                      end
                    end
                  end
                  span do
                    link_to remove_notification_image_admin_facility_path(facility, image_id: notification_image.id), style: 'color: red; text-decoration: none; padding-left: 5px; font-size: 20px;', data: {confirm: 'Are you sure?'} do
                      raw '&#10006;'
                    end
                  end
                end
              end
            end
          end
          ul do
            div class: 'col-md-3 active-admin-attachment-show' do
              li do
                link_to 'Add More', new_admin_notification_image_path, class: 'btn btn-primary'
              end
            end
          end
        end
      end
    end
  end

  member_action :remove_facility_form do
    fac_form = FacilityForm.find_by(id: params[:facility_form_id])
    fac = Facility.find_by(id: fac_form.facility_id)
    facility_form = fac.facility_forms.find_by_id(params[:facility_form_id])
    facility_form.destroy if facility_form.present?
    redirect_to admin_facility_path(fac), notice: 'Form removed'
  end

  member_action :remove_notification_image do
    notification_image =NotificationImage.find_by(id: params[:image_id])
    fac = Facility.find_by_id(notification_image.facility_id)
    notification_image = fac.notification_images.find_by_id(params[:image_id])
    notification_image.destroy if notification_image.present?
    redirect_to admin_facility_path(fac), notice: 'Notification image removed'
  end

end