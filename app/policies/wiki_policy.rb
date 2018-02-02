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

  private

  def wiki
    record
  end

end
