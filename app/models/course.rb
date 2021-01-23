class Course < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where(status: true)}

  has_many :user_courses
  has_many :users, through: :user_courses

end
