require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "associations" do
    it { should have_many(:invoices).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end