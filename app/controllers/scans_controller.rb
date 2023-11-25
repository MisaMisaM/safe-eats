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
      flash[:notice] = "Scan created successfully"
      redirect_to scan_path(@scan)
    else
      render json: { text: "Error creating scan" }, status: :unprocessable_entity
    end
  end

  def destroy
    @scan = Scan.find(params[:id])
     if @scan.created_at <= 1.hour.ago
      Cloudinary::Uploader.destroy(@scan.image_public_id)
     end
  end


  def show
    @scan = Scan.find(params[:id])
    @image_url = "https://res.cloudinary.com/dvqsmda6p/image/upload/v1698067820/development/#{@scan.image_url.key}"

    if @image_url.present?
      # consider running text extraction and saving the extracted text in database item, so you don't have to call the API everytime the page is refreshed
      google_vision_service = GoogleVisionService.new(@image_url)
      @extracted_text = google_vision_service.extract_text

      respond_to do |format|
        format.json do
          render json: { scan: @scan, extracted_text: @extracted_text }
        end
        format.html
      end

      # @additives = Additive.all
      # @additive_words = @extracted_text.gsub("\n", "").split(/\s+|、/)
      # @matching_additives = Additive.select { |additive| @extracted_text.include?(additive.name) || (@extracted_text.include?(additive.display_name) unless additive.display_name.nil?)}
      @matching_additives = Additive.select { |additive| additive.searchable_names.any? { |name| @extracted_text.gsub(/\s+/, "").include?(name) } }
      # @matching_additives = Additive.select { |additive| @extracted_text.include?(additive.display_name || additive.name)}

      # @additive_words.each do |word|
      #   @matching_additives.concat(@additives.select { |additive| word.include?(additive.name || additive.display_name) })
      # end

      @allergens = Allergen.all
      @allergen_words = @extracted_text.gsub("\n", "").split(/\s+|、/)
      @matching_allergens = []

      @allergen_words.each do |word|
        @matching_allergens.concat(@allergens.select { |allergen| word.include?(allergen.name) })
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
