class WikisController < ApplicationController
  before_action :authenticate_user!

  def show
    @wiki = Wiki.find(params[:id])
  end

  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(post_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki '#{@wiki.title[0..10]}...' was created."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error creating the wiki."
      render :new
    end
  end

  private

  def post_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
