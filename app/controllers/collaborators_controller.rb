class CollaboratorsController < ApplicationController
  def create
    @collaborator = Collaborator.new(collaborator_params)
    authorize @collaborator

    if @collaborator.save
      user = User.find(@collaborator.user_id)
      flash[:notice] = "Added #{user.username} to the collaborators list."
      redirect_to :back
    else
      flash.now[:alert] = "There was an error adding a collaborator."
      redirect_to :back
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    authorize @collaborator

    if @collaborator.destroy
      user = User.find(@collaborator.user_id)
      flash[:notice] = "Removed #{user.username} removed from collaborators list."
      redirect_to :back
    else
      flash.now[:alert] = "There was an error removing the collaborator."
      redirect_to :back
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
