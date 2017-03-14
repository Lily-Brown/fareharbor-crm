class ContactsController < ApplicationController
  before_action :get_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @contact = Contact.new
  end

  def create
    customer_id = params[:customer_id]
    @customer = Customer.find(customer_id)
    @contact = Contact.new(contact_params)
    @contact.full_name = @contact.first_name + " " + @contact.last_name
    @contact.customer_id = customer_id

    if @contact.save
      flash[:success] = "Contact added."
      redirect_to customer_path(@customer)
    else
      flash[:error] = "Contact has not been added."
      render customer_path(@customer)
    end
  end

  def show
  end

  def edit
  end

  def update
    @contact.update_attributes(contact_params)
    @contact.full_name = @contact.first_name + " " + @contact.last_name

    if @contact.save
      flash[:success] = "Contact updated successfully."
      redirect_to customer_contact_path(@contact)
    else
      flash[:error] = "Contact has not been updated."
      render :edit
    end
  end

  def destroy
    if @contact.destroy
      flash[:success] = "Contact deleted successfully."
      redirect_to customer_contacts_path
    else
      flash[:error] = "Contact has not been deleted."
      redirect_to customer_contact_path(@contact)
    end
  end

  private

  def get_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name,:last_name,:title,:work_phone,:email_address,:contact_id)
  end

end
