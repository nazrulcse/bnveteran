ActiveAdmin.register News do
  permit_params :title, :description, :photo

  index do
    selectable_column
    id_column
    column :title
    column "Attachment", :photo do |news|
      if news.photo.present?
        if news.photo.path.downcase.end_with?('.pdf')
          link_to news.photo_url, target: '_blank' do
            image_tag(news.photo_url(:medium_thumb_pdf))
          end
        elsif news.is_doc?
          raw("<iframe src='https://docs.google.com/viewer?embedded=true&url=#{news.doc_url(request.host) }' width='150' height='100' style='border: none;'>
          </iframe>")
        else
          link_to news.photo_url, target: '_blank' do
            news.photo_url(:thumb).present? ? image_tag(news.photo_url(:thumb)) : image_tag('facilityinner/gallery_photo/no-image-available.png')
          end
        end
      else
        image_tag('facilityinner/gallery_photo/no-image-available.png', width: 150, height: 100)
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :title

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      # f.input :description
      f.input :photo, label: 'Select File'

    end
    f.actions
  end

  show do
    div class: 'container' do
      attributes_table do
        row :id
        row :title
        row :created_at
        row :updated_at
        row :photo do |news|
          if news.photo.present?
            if news.photo.path.downcase.end_with?('.pdf')
              link_to news.photo_url, target: '_blank' do
                image_tag(news.photo_url(:medium_thumb_pdf))
              end
            elsif news.is_doc?
              raw("<iframe src='https://docs.google.com/viewer?embedded=true&url=#{news.doc_url(request.host) }' width='150' height='100' style='border: none;'>
          </iframe>")
            else
              link_to news.photo_url, target: '_blank' do
                image_tag(news.photo_url(:thumb)) if news.photo_url(:thumb)
              end
            end
          else
            image_tag('facilityinner/gallery_photo/no-image-available.png', width: 150, height: 100)
          end
        end
      end
    end
  end
end