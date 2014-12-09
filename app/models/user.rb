class User < ActiveRecord::Base
  scope :admins, -> { where(admin: true) }
  scope :by_name, -> { order(:name) }

  validates :email, presence: true

  has_secure_password
  has_many :tickets
  has_many :permissions

  def to_s
    "#{email} (#{admin? ? 'Admin' : 'User'})"
  end
end
