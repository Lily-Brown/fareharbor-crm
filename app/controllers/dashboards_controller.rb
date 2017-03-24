class DashboardsController < ApplicationController
  before_action :get_dashboard, only: [:edit, :update, :destroy]

  def index
    @dashboards = Dashboard.all.order(:order)
  end

  def new
    @dashboard = Dashboard.new
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)
    @dashboard.full_name = @dashboard.first_name + " " + @dashboard.last_name
    @dashboard.customer_id = params[:customer_id]
    reset_primary if @dashboard.is_primary === true

    if @dashboard.save
      flash[:success] = "Added to Dashboard."
      redirect_to customer_path(@customer)
    else
      flash[:error] = "Not Added to Dashboard: " +  @dashboard.errors.full_messages.join(". ") + "."
      redirect_to new_customer_dashboard_path(@customer)
    end
  end


  def edit
  end

  def update
    @dashboard.update_attributes(dashboard_params)

    if @dashboard.save
      flash[:success] = "Dashboard updated successfully."
      redirect_to dashboards_path
    else
      flash[:error] = "Dashboard has not been updated: " +  @dashboard.errors.full_messages.join(". ") + "."
      redirect_to edit_dashboard_path(@dashboard)
    end
  end

  def destroy
    if @dashboard.destroy
      flash[:success] = "Removed from Dashboard."
      redirect_to dashboards_path
    else
      flash[:error] = "Has not been removed from Dashboard."
      redirect_to @dashboard
    end
  end

  private

  def get_dashboard
    @dashboard = Dashboard.find(params[:id])
  end

  def dashboard_params
    params.require(:dashboard).permit(:order,:feature_request_id,:status)
  end

end
