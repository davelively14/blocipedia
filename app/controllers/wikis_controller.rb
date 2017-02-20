class WikisController < ApplicationController
  def show
    @wiki = Wiki.find(params[:id])
  end
end
