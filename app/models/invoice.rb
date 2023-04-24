class Invoice < ApplicationRecord
  belongs_to :client
  has_many :fees, dependent: :destroy
  has_many_attached :scans
  validates :number, presence: true, uniqueness: true
end
