class UcPeriodsController < ApplicationController

  layout 'admin'

  before_filter :find_default_period, :only => [:index, :under_construction]

  def index
    @uc_period ||= UcPeriod.new
    render 'show'
  end

  def update_msg_head
    @uc_period = UcPeriod.new(params[:uc_period])
    
    render :partial => 'update_msg_head'
  end

  def edit
    @uc_period = UcPeriod.find(params[:id])
  end

  def create
    @uc_period = UcPeriod.new(params[:uc_period])

    respond_to do |format|
      if @uc_period.save
        @uc_period.notify_users if params[:notify_users]
        flash[:notice] = l(:notice_tech_period_saved)
        format.html { redirect_to(:action => "index" ) }        
      else
        format.html { render 'show' }        
      end
    end
  end

  def update
    @uc_period = UcPeriod.find(params[:id])

    respond_to do |format|
      if @uc_period.update_attributes(params[:uc_period])
        @uc_period.notify_users if params[:notify_users]
        flash[:notice] = l(:notice_tech_period_saved)
        format.html { redirect_to(:action => "index") }
      else
        format.html { render 'show' }
      end
    end
  end

  def under_construction
    render 'under_construction', :layout => false
  end

  private

  def find_default_period
    @uc_period = UcPeriod.order("begin_date desc").first
  end

end