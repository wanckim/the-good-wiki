class User < ApplicationRecord
  has_many :wikis

  after_initialize :assign_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def assign_role
    self.role ||= :standard
  end

  enum role: [:admin, :premium, :standard, :guest]
end
