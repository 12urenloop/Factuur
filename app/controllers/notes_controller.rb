class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :destroy, :unarchive]

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
    @pdf_path = note_path(id: @note.id, format: :pdf)

    respond_to do |format|
      format.html
      format.json
      format.pdf { send_data(@note.generated_pdf.data, filename: 'factuur.pdf', type: :pdf, disposition: :inline) }
    end
  end

  # GET /notes/new
  def new
    @note = Note.new
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

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      flash[:success] = 'Factuur werd verwijderd.'
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  # POST /notes/1/unarchive
  def unarchive
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
      :id,
      :contact,
      :kind,
      costs_attributes: [:price, :description, :amount, :vat]
    )
  end
end
