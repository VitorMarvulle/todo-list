class User < ApplicationRecord
  has_secure_password validations: false
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :lists, dependent: :destroy



  validates :email_address, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
