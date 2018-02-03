class JobsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def my_applied_jobs
  end

  def search_job
  end

  def my_jobs
  end

  def search_cvs
  end

  def post_jobs
  end

  def suitable_bnv_for_jobs
  end
end
