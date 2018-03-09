class CollaboratorsController < ApplicationController
  before_action :authorize_user

  def create
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.build(:user_id => params[:user_id])

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

  private

  def authorize_user
    wiki = Wiki.find(params[:wiki_id])
    unless current_user == wiki.user || current_user.admin?
      flash[:alert] = "Only the owner of the wiki can assign collaborators."
      redirect_to [wiki]
    end
  end

end
