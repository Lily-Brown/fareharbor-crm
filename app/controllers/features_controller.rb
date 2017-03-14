class FeaturesController < ApplicationController
  before_action :get_feature, only: [:show, :edit, :update, :destroy]
  before_action :get_customer
  before_action :get_feature_request

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(feature_params)
    @feature.feature_request_id = params[:feature_request_id]

    if @feature.save
      flash[:success] = "Feature added."
      redirect_to customer_feature_request_path(@customer,@feature_request)
    else
      flash[:error] = "Feature has not been added."
      redirect_to customer_feature_request_path(@customer,@feature_request)
    end
  end

  def show
  end

  def edit
  end

  def update
    @feature.update_attributes(feature_params)
    
    if @feature.save
      flash[:success] = "Feature updated successfully."
      redirect_to customer_feature_request_path(@customer,@feature_request)
    else
      flash[:error] = "Feature has not been updated."
      render :edit
    end
  end

  def destroy
    if @feature.destroy
      flash[:success] = "Feature deleted successfully."
      redirect_to customer_feature_request_path(@customer,@feature_request)
    else
      flash[:error] = "Feature has not been deleted."
      redirect_to customer_feature_request_path(@customer,@feature_request)
    end
  end

  private

  def get_feature
    @feature = Feature.find(params[:id])
  end

  def get_customer
    @customer = Customer.find(params[:customer_id])
  end

  def get_feature_request
    @feature_request = FeatureRequest.find(params[:feature_request_id])
  end

  def feature_params
    params.require(:feature).permit(:name,:bug_request,:feature_request_id,:status)
  end

end
