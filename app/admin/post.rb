ActiveAdmin.register Post do
  permit_params :user_id, :content, :attachments
  controller do
    def action_methods
      super - ['new', 'create']
    end
  end

  index do
    selectable_column
    id_column
    column :content do |post|
      truncate( raw(post.content), length: 50)
    end
    column 'Total comments' do |post|
      link_to post.comments_count, admin_post_path(post), title: 'Click to see all comments'

    end
    column :user
    actions
  end

  filter :content
  filter :created_at
  filter :updated_at

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :content
      f.input :attachments
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :content do |post|
        raw post.content
      end
      row :created_at
      row :updated_at
      row :attachments do |post|
        if post.attachments.present?
          span do
            link_to post.attachments.url, target: '_blank' do
              image_tag(post.attachments.url(:thumb))
            end
          end
          span do
            link_to remove_post_image_admin_post_path(post), style: 'color: red; text-decoration: none; padding-left: 5px; font-size: 20px;', data: {confirm: 'Are you sure?'} do
              raw '&#10006;'
            end
          end

        end
      end
    end

    panel "Comments (#{post.comments_count})" do
      table_for post.comments, class:'table table-responsive table-strip' do
        column :comment
        column :user
        column :created_at
      end
    end

  end

  member_action :remove_post_image do
    pst = Post.find_by_id(params[:id])
    if pst.present?
      pst.attachments = ''
      pst.save
    end
    redirect_to admin_post_path(pst), notice: 'Image removed'
  end
end
