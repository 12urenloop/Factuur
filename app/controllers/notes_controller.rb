class NotesController < ApplicationController
  before_action :set_note, only: [:edit, :update, :archive, :delete, :destroy, :destroy_fully!, :unarchive]

  # GET /notes
  # GET /notes.json
  def index
    @archived = params[:archived].present?
    if @archived
      @notes = Note.deleted.order(created_at: :desc)
    else
      @notes = Note.all.order(created_at: :desc)
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find_by_note_number_or_id(params[:id])
    @pdf_path = note_path(id: @note.note_number, format: :pdf)
    respond_to do |format|
      format.html
      format.json
      format.pdf { send_data(@note.generated_pdf, filename: 'factuur.pdf', type: :pdf, disposition: :inline) }
    end
  end

  # GET /notes/new
  def new
    if params[:id]
      @note = Note.find(params[:id]).clone
      @note.note_number = Note.next_note_number
    else
      @note = Note.new
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new note_params

    respond_to do |format|
      if @note.save
        flash[:success] = 'Factuur werd aangemaakt.'
        format.html { redirect_to @note }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update note_params
        format.html { redirect_to notes_path, notice: 'Factuur werd aangepast.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /notes/1/archive
  def archive
    @note = Note.unscoped.find params[:id]
    @note.destroy
    redirect_back fallback_location: notes_path, notice: 'Factuur werd gearchiveerd.'

    #respond_to do |format|
    #  flash[:success] = 'Factuur werd gearchiveerd.'
    #  format.html { redirect_to notes_url }
    #  format.json { head :no_content }
    #end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.unscoped.find params[:id]
    @note.really_destroy!
    redirect_back fallback_location: notes_path, notice: 'Factuur werd verwijderd.'
  end

  # POST /notes/1/unarchive
  def unarchive
    @note = Note.unscoped.find params[:id]
    @note.restore
    redirect_back fallback_location: notes_url, notice: 'Factuur werd hersteld.'
  end

  def preview
    render(
      :note_pdf,
      layout: 'paper',
      locals: {
        base_url: request.base_url,
        note: Note.first,
        contact: Contact.first
      }
    )
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.unscoped.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(
      :contact_id,
      :title,
      :kind,
      costs_attributes: [:id, :price, :description, :amount, :vat]
    )
  end
end
