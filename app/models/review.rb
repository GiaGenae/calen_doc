class Review < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :rating, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :doctor, uniqueness: { scope: :user, message: "has already been reviewed by you."}
end
