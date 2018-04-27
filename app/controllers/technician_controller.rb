class TechnicianController < ApplicationController

  before_action :set_paper_trail_whodunnit

  before_filter :signed_in_user

  def index
    respond_to do |format|
      @job_id = params[:job_id]
      format.html { render layout: 'aq2' }
    end
  end

end
