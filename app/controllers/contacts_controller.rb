class ContactsController < ApplicationController
  before_action :get_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.full_name = @contact.first_name + " " + @contact.last_name

    if @contact.save
      flash[:success] = "Contact added."
      redirect_to contacts_path
    else
      flash[:error] = "Contact has not been added."
      render contacts_path
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
      redirect_to @contact
    else
      flash[:error] = "Contact has not been updated."
      render :edit
    end
  end

  def destroy
    if @contact.destroy
      flash[:success] = "Contact deleted successfully."
      redirect_to contacts_path
    else
      flash[:error] = "Contact has not been deleted."
      redirect_to @contact
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
