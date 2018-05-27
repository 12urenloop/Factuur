class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @archived = params[:archived].present?
    if @archived
      @contacts = Contact.deleted
    else
      @contacts = Contact.all
    end
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, notice: 'Contact werd aangemaakt.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update contact_params
        format.html { redirect_to contacts_path, notice: 'Contact werd aangepast.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact werd gearchiveerd.' }
      format.json { head :no_content }
    end
  end

  # POST /contacts/1/unarchive
  def unarchive
    @contact = Contact.unscoped.find params[:id]
    @contact.restore
    redirect_back(fallback_location: contacts_url, notice: 'Contact werd hersteld.')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name, :vatnumber, address: [:beneficiary, :street, :zip_code, :city, :country])
  end
end
