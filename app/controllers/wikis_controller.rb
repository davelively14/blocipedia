class WikisController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @wiki = Wiki.find(params[:id])
  end

  def index
    @wikis = Wiki.all
  end
end
