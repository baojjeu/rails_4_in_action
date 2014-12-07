class Project < ActiveRecord::Base
  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: 'view', user_id: user.id })
  end

  scope :for, ->(user) do
    user.admin? ? all : viewable_by(user)
  end

  validates :name, presence: true

  has_many :tickets, dependent: :delete_all
  has_many :permissions, as: :thing
end
