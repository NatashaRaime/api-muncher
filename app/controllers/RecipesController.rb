require "edamam_wrapper"
require "recipe"
require "welcome"
class RecipesController < ApplicationController
  def index
    @data = Recipes.all
  end

  def create
    RecipesWrapper.search(params[:query])
    redirect_to recipes_path
  end

  def new
    @label = params[:query]
  end

  def find
    @data = Recipe.find
  end

  def create
    result = Recipe.by_name(params[:label])
    if result == nil
      flash[:notice] = "Search Failed for #{params[:query]}: #{result["error"]}"
    end
    redirect_to recipes_path
  end

  def new
    @recipe_name = params[:label]
  end



  private

  def recipe_params
    params.require(:query).permit(:label, :health, :diet, :calories)
  end
end
