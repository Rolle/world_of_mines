class UserNotesController < ApplicationController
  #before_action :log

  #def log
  #  puts "---"  + action_name + "---"
  #end

  def index
  	@usernote = UserNote.where(user_id: current_user.id).first
  	if @usernote.nil?
  		@usernote = UserNote.new
  	end
  end

  def create
  	@usernote = UserNote.new()
  	@usernote.text = params[:text]
  	@usernote.user_id = current_user.id
  	@usernote.save
  	render action: 'index'
  end

  def update
  	@usernote = UserNote.find(params[:id])
  	@usernote.text = params[:user_note][:text] 
   	@usernote.save!
  	render action: 'index'
  end


private
    def note_params
      params.require(:user_note).permit(:text)
    end
end


