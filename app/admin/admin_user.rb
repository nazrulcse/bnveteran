ActiveAdmin.register AdminUser do
  permit_params :name, :email, :password, :password_confirmation, :role, :photo
  menu :if => proc{ current_admin_user.super_admin? }
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    # column :photo
    column :photo do |news|
      if news.photo.present?
        link_to news.photo_url, target: '_blank' do
          image_tag(news.photo_url(:thumb))
        end
      else
        image_tag('default-profile-picture.png', width: '95', height: '110')
      end
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :email


  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :email
      f.input :role, as: :select, collection: ['Admin', 'Super_admin']
      f.input :photo
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    div class: 'container' do
      attributes_table do
        row :id
        row :name
        row :email
        row :role
        row :created_at
        row :updated_at
        row :photo do |news|
          if news.photo.present?
            link_to news.photo_url, target: '_blank' do
              image_tag(news.photo_url(:thumb))
            end
          end
        end
      end
    end
  end

end
