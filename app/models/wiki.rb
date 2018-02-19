class Wiki < ApplicationRecord
  belongs_to :user

  has_many :collaborators, dependent: :destroy

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) {(user.admin? || user.premium?) ? all : joins(:wiki).where('wiki.private' => false)}

  validates :title, length:{ minimum: 3 }, presence: true
  validates :body, length:{ minimum: 8 }, presence: true
  validates :user, presence: true

  def collaborated(user)
    collaborators.where(user_id: user.id).first
  end

end
