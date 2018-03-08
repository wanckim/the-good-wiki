class CollaboratorsController < ApplicationController
  # before_action :require_sign_in

  def create
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.build(params[:user_id])

    if collaborator.save
      flash[:notice] = "Added collaborator."
    else
      flash[:alert] = "Unable to add collaborator."
    end

    redirect_to [wiki]
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.find(params[:id])

    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:alert] = "Removing failed."
    end
      redirect_to [wiki]
  end
end
