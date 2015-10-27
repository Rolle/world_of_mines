class NotesController < ApplicationController


  def index
  	@note = Note.first
  	if @note.nil?
  		@note = Note.new
  	end
  end

  def create
  	@note = Note.new()
  	@note.text = params[:text]
  	@note.user_id = current_user.id
  	@note.save
  	render action: 'index'
  end

  def update
  	@note = Note.find(params[:id])
  	@note.text = params[:note][:text] 
  	@note.user_id = current_user.id
  	@note.save!
  	render action: 'index'
  end


private
    def note_params
      params.require(:note).permit(:text)
    end
end


