class RecipesApiController < ApplicationController
  def index
    @data = RecipesWrapper
  end

  def create
    RecipesApiWrapper.sendmsg(params[:channel], params[:message])
    redirect_to root_path
  end

  def new
    @channel_name = params[:channel]
  end

  def find
    @data = Channel.find
  end
end
