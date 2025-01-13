class Task < ApplicationRecord
  belongs_to :list
  belongs_to :user

  validates :title, presence: true
end
