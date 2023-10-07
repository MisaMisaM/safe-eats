class AdditivesController < ApplicationController

  def index

    @additives = Additive.all
    @additives = @additives.search_by_aa(params[:query]) if params[:query].present?
    @additive = Additive.new

  end
end
