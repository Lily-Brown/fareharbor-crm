class CustomersController < ApplicationController
  before_action :get_customer, only: [:show, :edit, :update, :destroy]

  def index 
    @customers = Customer.all.order(:name)
  end 

  def new
    @customer = Customer.new
    @customer.last_contact_date = Time.now
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:success] = "Customer added."
      redirect_to customers_path
    else
      flash[:error] = "Customer has not been added: " +  @customer.errors.full_messages.join(". ") + "."
      render new_customer_path(@customer)
    end
  end

  def show
    @feature_requests = FeatureRequest.where(:customer_id => @customer.id)
  end

  def edit
  end

  def update
    @customer.update_attributes(customer_params)

    if @customer.save
      flash[:success] = "Customer updated successfully."
      redirect_to @customer
    else
      flash[:error] = "Customer has not been updated: " +  @customer.errors.full_messages.join(". ") + "."
      redirect_to edit_customer_path(@customer)
    end
  end

  def destroy
    if @customer.destroy
      flash[:success] = "Customer deleted successfully."
      redirect_to customers_path
    else
      flash[:error] = "Customer has not been deleted."
      redirect_to @customer
    end
  end

  private

  def get_customer
    @customer = Customer.find(params[:id])
  end


  def customer_params
    params.require(:customer).permit(:name,:street_address,:city,:state,:zip_code,:work_phone,:last_contact_date)
  end

end
