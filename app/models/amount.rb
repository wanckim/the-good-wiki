class Amount < ApplicationRecord
  validates :price, numericality: {equal_to: 1500}, presence: true

  def self.default
    1500
  end
end
