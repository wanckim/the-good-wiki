class Collaborator < ApplicationRecord
  belongs_to :user
  belongs_to :wiki

  validates :user, presence: true
  validates :wiki, presence: true
end
