class AdditivesController < ApplicationController

  def index
    @additives = Additive.all.order(:name)
    @allergens = Allergen.all.order(:name)



    if params[:query].present?
      @additives = @additives.where('name ILIKE ?', "%#{params[:query]}%")
    end
    # @additives = @additives.search_by_aa(params[:query]) if params[:query].present?
    respond_to do |format|
      format.html
      format.text { render partial: "result", locals: { additives: @additives }, formats: [:html] }
    end
  end
end
