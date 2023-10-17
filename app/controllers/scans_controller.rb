class ScansController < ApplicationController
  require 'google/cloud/vision'
  require_relative '../../services/google_vision'

  def index
    @scans = Scan.all

    image_url = "https://jlgstg.blob.core.windows.net/cache/f/4/f/1/f/b/f4f1fb240f2cc39d9ce7a9b067f9fe3e9961fade.jpg"
    vision_service = GoogleVisionService.new(image_url)
    @extracted_text = vision_service.extract_text

    if @extracted_text.nil?
      @error_message = "No text found in the image."
    end

    respond_to do |format|
      format.json { render json: { scans: @scans, extracted_text: @extracted_text } }
    end
  end

  def new
  end

  def create
  end

  def show
  end

  def capture
    @scan = Scan.new(image_url: params[:image])

    if @scan.save
      render json: { text: "Scan created successfully" }
    else
      render json: { text: "Error creating scan" }, status: :unprocessable_entity
    end
  end
  # private

  # def image_params
  #   params.require(:image).permit(:image)
  # end
end
