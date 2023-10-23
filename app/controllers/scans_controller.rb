class ScansController < ApplicationController
  require 'google/cloud/vision'
  require_relative '../../services/google_vision'

  def index
  end

  def new
    render :new
  end

  def create
    @scan = Scan.new(image_params)

    if @scan.save
      # Instead of using `@scan.image.url`, use the URL of the attached image
      @scan.image_url = url_for(@scan.image_url) # This gets the URL of the attached image

      flash[:notice] = "Scan created successfully"
      redirect_to scan_path(@scan)
    else
      render json: { text: "Error creating scan" }, status: :unprocessable_entity
    end
  end


  def show
    @scan = Scan.find(params[:id])

    image_url = @scan.image_url
    vision_service = GoogleVisionService.new(image_url)
    @extracted_text = vision_service.extract_text

    if @extracted_text.nil?
      @error_message = "No text found in the image."
    end

    respond_to do |format|
      format.json { render json: { scans: @scans, extracted_text: @extracted_text } }
      format.html # This line renders the HTML view for the show action
    end
  end


 private

 def image_params
  params.require(:scan).permit(:image_url)
  end
end
