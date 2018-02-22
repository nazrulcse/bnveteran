class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:search]
  before_action :set_user, except: :front
  respond_to :html, :js

  def index
    @hashtags = SimpleHashtag::Hashtag.all
    @post = Post.new
    @friends = @user.all_following.unshift(@user)

    @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @un_friends = User.where.not(id: @friends.unshift(@user)).limit(5)
  end

  def search
    if params[:value].present?
      @users = User.search(params[:value]).where.not(id: current_user.id)
      post_ids = Post.search(params[:value]).ids
      @activities = PublicActivity::Activity.where(trackable_id: post_ids, trackable_type: 'Post').order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end
  end

  def home
    @hashtags = SimpleHashtag::Hashtag.all
    @post = Post.new
    @friends = @user.all_following.unshift(@user)

    @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @un_friends = User.where.not(id: @friends.unshift(@user)).limit(5)
  end

  def front
    @facilities = Facility.order(created_at: :asc)
    @activities = PublicActivity::Activity.joins("INNER JOIN users ON activities.owner_id = users.id").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @meta_title = meta_title 'BN Veteran official home page'
    @meta_description = 'BN Veteran is a social site for Bangladesh Navy veterans to communicate each other among them.'

  end

  # def forms
  #   @facility_forms = FacilityForm.order(:title).paginate(page: params[:page], per_page: 9)
  # end

  
  def bnchsl_form
    pdf_filename = File.join("app/assets/pdf/1.pdf")
    send_file(pdf_filename, :filename => "bnchsl.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def bnbf_form
    pdf_filename = File.join("app/assets/pdf/6.pdf")
    send_file(pdf_filename, :filename => "bnbf.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def education_grant_form
    pdf_filename = File.join("app/assets/pdf/2.pdf")
    send_file(pdf_filename, :filename => "education_grant.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def financial_grant_form
    pdf_filename = File.join("app/assets/pdf/4.pdf")
    send_file(pdf_filename, :filename => "financial_grant.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def armed_form_service
    pdf_filename = File.join("app/assets/pdf/5.pdf")
    send_file(pdf_filename, :filename => "armed_service.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def sena_kallyan_facilities_form
    pdf_filename = File.join("app/assets/pdf/3.pdf")
    send_file(pdf_filename, :filename => "sena_kallyan_facilities.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def photo_gallery
    @albums = Album.all
  end

  def news_and_event
    @events = Event.paginate(:page => params[:page], :per_page => 4)
  end

  def contact
    @contact = Contact.new
  end

  def contact_submit
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to root_path, notice: 'Your message has been successfully sent.'
    else
      redirect_to root_path, notice: 'Your message faild to sent.'
    end
  end


  def former_cns
  end

  def chief_more
  end

  def bnchsl_more
  end

  def bnbf_more
  end

  def education_grant_more
  end

  def financial_grant_more
  end

  def armed_services_more
  end

  def sena_kallyan_sangstha_more
  end

  def event_single
  end

  def email_template
  render layout: false
  end
  def email_temoplate
    render layout: false
  end

  def find_friends
    @friends = @user.all_following
    @users =  User.where.not(id: @friends.unshift(@user)).paginate(page: params[:page])
  end

  private
  def set_user
    @user = current_user
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end

end
