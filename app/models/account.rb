class Account < ActiveRecord::Base
  belongs_to :bank

  validates :iban, uniqueness: true, presence: true, length: { maximum: 250 }

end
