class Account < ActiveRecord::Base
  belongs_to :bank

  validates :iban, uniqueness: true, presence: true, length: { maximum: 50 }
  validates :holder, presence: true, length: { maximum: 100 }

end
