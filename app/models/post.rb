class Post < ApplicationRecord
  has_one_attached :image

  def self.ransackable_attributes(_user)
    []
  end

  def self.ransackable_associations(_user)
    []
  end
end
