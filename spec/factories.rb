# require 'rails_helper'

FactoryBot.define do
	factory :client do
		name { Faker::Company.name }
	end
end

FactoryBot.define do
	factory :invoice do
		number { Faker::Number.number(digits: 6) }
		amount { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
		due_date { Faker::Date.between(from: 1.month.ago, to: 1.month.from_now) }
		status { "created" }
		fee_percentage { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
		fee_start_date { Faker::Date.between(from: 2.months.ago, to: 1.month.ago) }
		fee_closing_date { Faker::Date.between(from: Date.today, to: 1.month.from_now) }
		scan { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'invoice.pdf'), 'application/pdf') }

		association :client
	end
end
