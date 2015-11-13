class DocumentsController < ApplicationController

  def index
  	@document = Document.new
  	@documents = Document.page(params[:page])
  end

  def create
    @document = Document.new(document_params)
    @document.user = current_user
    if @document.save
      respond_to do |format|
        format.js {}
      end  
    end
  end
  
  def destroy
    @document = Document.find(params[:id])
    log_event(nil, 1, "Dokument", "Löschung von Dokument: " + @document.file.path)
    @document.destroy
    respond_to do |format|
      format.js {}
    end
  end

private
    def document_params
      params.require(:document).permit(:user, :file, :description)
    end
end


