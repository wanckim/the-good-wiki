class WikiPolicy < ApplicationPolicy
  def index
    true
  end

  def show?
    unless wiki.private
      user.present?
    else
      if user.present?
        user.admin? || user == wiki.user
      end
    end
  end

  def create?
    user.present?
  end

  def update?
    user.present? ? user.admin? || user == wiki.user : false
  end

  def destroy?
    user.present? ? user.admin? || user == wiki.user : false
  end

  class Scope < WikiPolicy
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def resolve
    wikis = []
    if user && user.admin?
      wikis = scope.all # if the user is an admin, show them all the wikis
    elsif user && user.premium?
      all_wikis = scope.all
      all_wikis.each do |wiki|
        if (not wiki.private?) || wiki.user == user || wiki.collaborators.include?(user)
          wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
        end
      end
    else # this is the lowly standard user
      all_wikis = scope.all
      wikis = []
      all_wikis.each do |wiki|
        if (not wiki.private?) || wiki.collaborators.include?(user)
          wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
        end
      end
    end
    wikis # return the wikis array we've built up
  end
end

  private

  def wiki
    record
  end

end
