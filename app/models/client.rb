class Client < ApplicationRecord
    has_many :invoices, dependent: :destroy
    validates_presence_of :name
end
