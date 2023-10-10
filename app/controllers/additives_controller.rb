class AdditivesController < ApplicationController

  def index
    @additives = Additive.all.order(:name)
    @allergens = Allergen.all.order(:name)
    @additives = @additives.search_by_aa(params[:query]) if params[:query].present?
  end
end
