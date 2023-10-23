class ScansController < ApplicationController
  require 'google/cloud/vision'
  require_relative '../../services/google_vision'


  def index
  end

  def new
    @scan = Scan.new
    render :new
  end

  def create
    @scan = Scan.new(image_params)

    if @scan.save
      # Use the Cloudinary URL of the attached image
      flash[:notice] = "Scan created successfully"
      redirect_to scan_path(@scan)
    else
      render json: { text: "Error creating scan" }, status: :unprocessable_entity
    end
  end


  def show
    @scan = Scan.find(params[:id])
    @image_url = "https://res.cloudinary.com/dvqsmda6p/image/upload/v1698067820/development/#{@scan.image_url.key}"

    if @image_url.present?
      google_vision_service = GoogleVisionService.new(@image_url)
      @extracted_text = google_vision_service.extract_text

      respond_to do |format|
        format.json do
          render json: { scan: @scan, extracted_text: @extracted_text }
        end
        format.html
      end
    else
      @error_message = "Image URL is missing."
      respond_to do |format|
        format.json do
          render json: { scan: @scan, error: @error_message }, status: :unprocessable_entity
        end
        format.html
      end
    end
  end

 private

 def image_params
  params.require(:scan).permit(:image_url)
  end
end
