class Bank < ActiveRecord::Base
  has_many :accounts
  has_many :transfers

  validates :name, uniqueness: true, presence: true, length: { maximum: 250 }


end
