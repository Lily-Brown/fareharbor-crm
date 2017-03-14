class CustomersController < ApplicationController
  before_action :get_customer, only: [:show, :edit, :update, :destroy]

  def index 
    @customers = Customer.all
  end 

  def new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:success] = "Customer added."
      redirect_to customers_path
    else
      flash[:error] = "Customer has not been added."
      render customers_path
    end
  end

  def show
  end

  def edit
  end

  def update
    @customer.update_attributes(customer_params)

    if @customer.save
      flash[:success] = "Customer updated successfully."
      redirect_to @customer
    else
      flash[:error] = "Customer has not been updated."
      render :edit
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
    params.require(:customer).permit(:name,:street_address,:city,:state,:zip_code,:work_phone)
  end

end
