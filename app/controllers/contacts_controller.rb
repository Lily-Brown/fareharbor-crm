class ContactsController < ApplicationController
  before_action :get_contact, only: [:show, :edit, :update, :destroy]
  before_action :get_customer, except: [:index]

  def index
    @contacts = Contact.where(:customer_id => params[:customer_id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.full_name = @contact.first_name + " " + @contact.last_name
    @contact.customer_id = params[:customer_id]
    reset_primary if @contact.is_primary === true

    if @contact.save
      flash[:success] = "Contact added."
      redirect_to customer_path(@customer)
    else
      flash[:error] = "Contact has not been added. " +  @contact.errors.full_messages.join(". ") + "."
      redirect_to new_customer_contact_path(@customer)
    end
  end

  def show
  end

  def edit
  end

  def update
    @contact.update_attributes(contact_params)
    @contact.full_name = @contact.first_name + " " + @contact.last_name
    reset_primary if @contact.is_primary === true

    if @contact.save
      flash[:success] = "Contact updated successfully."
      redirect_to customer_contact_path(@customer,@contact)
    else
      flash[:error] = "Contact has not been updated. " +  @contact.errors.full_messages.join(". ")
      redirect_to edit_customer_contact_path(@customer,@contact)
    end
  end

  def destroy
    if @contact.destroy
      flash[:success] = "Contact deleted successfully."
      redirect_to customer_path(@customer)
    else
      flash[:error] = "Contact has not been deleted."
      redirect_to customer_path(@customer)
    end
  end

  private

  def get_contact
    @contact = Contact.find(params[:id])
  end

  def get_customer
    @customer = Customer.find(params[:customer_id])
  end

  def reset_primary
    current_primary = Contact.where(:is_primary => true)
    if (current_primary.length > 0 && current_primary[0])
      current_primary[0].is_primary = false
      current_primary[0].save
    end
  end

  def contact_params
    params.require(:contact).permit(:first_name,:last_name,:title,:work_phone,:email_address,:contact_id,:is_primary)
  end

end
