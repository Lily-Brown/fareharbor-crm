class FeatureRequestsController < ApplicationController
  before_action :get_feature_request, only: [:show, :edit, :update, :destroy]
  before_action :get_customer, except: [:index]

  def index
    @feature_requests = FeatureRequest.all.order(:status)
  end

  def new
    @feature_request = FeatureRequest.new
    @feature_request.request_date = Time.now
  end

  def create
    @feature_request = FeatureRequest.new(feature_request_params)
    @feature_request.customer_id = params[:customer_id]

    if @feature_request.save
      flash[:success] = "Feature Request added."
      redirect_to customer_path(@customer)
    else
      flash[:error] = "Feature Request has not been added: " +  @feature_request.errors.full_messages.join(". ") + "."
      redirect_to customer_path(@customer)
    end
  end

  def show
    @features = Feature.where(:feature_request_id => @feature_request.id).order(:status)
  end

  def edit
  end

  def update
    @feature_request.update_attributes(feature_request_params)
    
    if @feature_request.save
      flash[:success] = "Feature Request updated successfully."
      redirect_to customer_feature_request_path(@customer,@feature_request)
    else
      flash[:error] = "Feature Request has not been updated: " +  @feature_request.errors.full_messages.join(". ") + "."
      render :edit
    end
  end

  def destroy
    if @feature_request.destroy
      flash[:success] = "Feature Request deleted successfully."
      redirect_to customer_path(@customer)
    else
      flash[:error] = "Feature Request has not been deleted: " +  @feature_request.errors.full_messages.join(". ") + "."
      redirect_to customer_path(@customer)
    end
  end

  private

  def get_feature_request
    @feature_request = FeatureRequest.find(params[:id])
  end

  def get_customer
    if (params[:customer_id])
      @customer = Customer.find(params[:customer_id])
    else
      @customer = Customer.find(params[:feature_request][:customer_id])
    end
  end

  def feature_request_params
    params.require(:feature_request).permit(:name,:request_date,:contact_id,:customer_summary,:status)
  end

end
