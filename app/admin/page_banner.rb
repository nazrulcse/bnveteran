ActiveAdmin.register PageBanner, as: "Hero Banners" do
  permit_params :menu_bar_item_id, :banner_photo
  index do
    selectable_column
    id_column
    column "Category ",:menu_bar_item
    column :banner_photo do |page_banner|
      if page_banner.banner_photo.present?
        link_to page_banner.banner_photo_url, target: '_blank' do
          image_tag(page_banner.banner_photo_url(:thumb))
        end
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :menu_bar_item

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :menu_bar_item_id, as: :select, collection: MenuBarItem.all
      f.input :banner_photo, :as => :file, :hint => f.object.banner_photo.present? ? image_tag(f.object.banner_photo_url(:thumb)):content_tag(:span, "no Slider image chosen yet")

    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :menu_bar_item
      row :created_at
      row :updated_at
      row :banner_photo do |page_banner|
        if page_banner.banner_photo.present?
          link_to page_banner.banner_photo_url, target: '_blank' do
            image_tag(page_banner.banner_photo_url(:thumb))
          end
        end
      end
    end
  end
end