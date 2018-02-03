class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:select_rank, :search_user, :cv_upload, :doc_upload, :post_job, :find_people, :search_recent_users, :check_status]
  before_action :check_ownership, only: [:edit, :update, :cover_and_profile_photo_update]
  skip_before_action :authenticate_user!, only: [:check_status]
  skip_before_filter :verify_authenticity_token
  respond_to :html, :js

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.js { @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc) } #.paginate(page: params[:page], per_page: 10)
      format.html { @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc) } #.paginate(page: params[:page], per_page: 10)
    end
  end

  def show_profile
    @user = User.find(params[:id])
  end

  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    respond_to do |format|
      p params.inspect
      if @user.update_attributes(user_params)
        if params[:avatar].present?
          if params[:avatar] != "undefined"
            @user.update(avatar: params[:avatar])
          end
        end

        if params[:cover].present?
          if params[:cover] != "undefined"
            @user.update(cover: params[:cover])
          end
        end

        @user.remove_role :Job_Seeker
        @user.remove_role :Employer
        if params[:user][:roles].present?
          user_roles = params[:user][:roles]
          if user_roles.include? 'Job_Seeker'
            @user.add_role :Job_Seeker
          end

          if user_roles.include? 'Employer'
            @user.add_role :Employer
          end
        end
        format.html { redirect_to user_path(@user), notice: "Data successfully updated" }
        format.js { @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc)}
      else
        format.html { render :edit, notice: 'Failed to Update. Try again' }
        format.js { @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc)}
      end
    end
  end

  def deactivate
  end

  def friends
    @friends = @user.following_users.paginate(page: params[:page])
  end

  def followers
    @followers = @user.user_followers.paginate(page: params[:page])
  end

  def cv_upload
    @user = current_user
  end

  def mentionable
    render json: @user.following_users.as_json(only: [:id, :name]), root: false
  end

  def select_rank
    @user = current_user
    @ranks = []
    if params[:value].to_i.eql?(1)
      @ranks = User::OFFICER
    elsif params[:value].to_i.eql?(2)
      @ranks = User::JCO
    end
    respond_to do |format|
      format.js
    end
  end

  def doc_upload
    current_user.update(avatar_pdf: params[:avatar])
  end

  def search_user
    @users = find_users
  end

  def post_job
  end

  def find_people
    respond_to do |format|
      @user = current_user
      if params[:value].present?
        @users = User.search(params[:value]).where.not(id: current_user.id)
      else
        @users = User.all.where.not(id: current_user.id, status: false)
      end
      format.html
      format.js
    end
  end

  def search_recent_users
    @users = find_users
  end

  def check_status
    if params[:value].present?
      @user = User.find_by(officer_no: params[:value]) || User.find_by(email: params[:value])
      if @user.present?
        if @user[:status] == true
          render json: "true"
        else
          render json: "false"
        end
      end
    end
  end

  def cover_and_profile_photo_update
    respond_to do |format|

      #@user = User.find(params[:id])
      # if @user.present?
      #   if @user.avatar.present?
      #     @user.update(avatar: params[:avatar])
      #   elsif @user.cover.present?
      #     @user.update(cover: params[:cover])
      #   end
      #   format.html { redirect_to user_path(current_user), notice: "Data successfully updated" }
      #   format.js
      # else
      #   format.html { redirect_to user_path(current_user), notice: "Data faild to update, try again! " }
      #   format.js
      # end


      if @user.update_attributes(user_params)

        if params[:avatar].present?
          if params[:avatar] != "undefined"
            @user.update(avatar: params[:avatar])
          end
        end

        if params[:cover].present?
          if params[:cover] != "undefined"
            @user.update(cover: params[:cover])
          end
        end
        format.js
      end
    end
  end

  def delete_cover_img
    @user = current_user
    @user.cover.remove!
    #redirect_to edit_user_path(current_user)
  end

  def delete_profile_img
    @user = current_user
    @user.avatar.remove!
    #redirect_to edit_user_path(current_user)
  end

  def calculate_count
    @followers = current_user.following_users.count
    @posts = current_user.posts_count
    @following = current_user.following_users.count
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :name, :about, :avatar, :cover,:avatar_pdf,
                                 :sex, :dob, :location, :phone_number,:designation_type,:rank,:officer_no, :date_joining,:date_retirement, :batch, :permanent_address,:present_address, :state, :city, :country, :present_state, :present_city, :present_country, :status, :roles)
  end

  def check_ownership
    redirect_to current_user, notice: 'Not Authorized' unless @user == current_user
  end

  def set_user
    @user = User.friendly.find_by(slug: params[:id]) || User.find_by(id: params[:id])
    render_404 and return unless @user
  end

  def find_users
    @users_by_name = User.where("name LIKE :query", query: "%#{params[:value]}%")
    #@users_by_email = User.where("email LIKE :query", query: "%#{params[:value]}%")
    @users = User.where("name LIKE ? OR email LIKE ? OR batch LIKE ? OR officer_no LIKE ?", "%#{params[:value]}% ", "%#{params[:value]}%", "%#{params[:value]}%", "%#{params[:value]}%").or(User.where(rank:params[:value])).or(User.where(phone_number: params[:value]))
  end

end