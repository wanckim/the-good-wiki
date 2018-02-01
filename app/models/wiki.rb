class Wiki < ApplicationRecord
  belongs_to :user

  default_scope { order('created_at DESC') }

  validates :title, length:{ minimum: 5 }, presence: true
  validates :body, length:{ minimum: 15 }, presence: true
  validates :user, presence: true
end
