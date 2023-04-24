class Invoice < ApplicationRecord
  belongs_to :client
  has_many :fees, dependent: :destroy
  validates :number, presence: true, uniqueness: true
end
