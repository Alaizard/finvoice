require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Invoice, type: :model do
  let(:client) { FactoryBot.create(:client) }
  let(:invoice) { FactoryBot.create(:invoice, client_id: client.id) }
  
    describe "associations" do
      it { should belong_to(:client) }
      it { should have_one_attached(:scan) }
    end
  
    describe "validations" do
      it { should validate_presence_of(:number) }
    end
  
    describe "enums" do
      it { should define_enum_for(:status).with_values(created: 0, approved: 1, rejected: 2, purchased: 3, closed: 4) }
    end
  
    describe "scopes" do
      describe ".open" do
        it "returns invoices with a status other than rejected" do
          open_invoice = create(:invoice, client: client, status: "created")
          rejected_invoice = create(:invoice, client: client, status: "rejected")
          expect(Invoice.open).to include(open_invoice)
          expect(Invoice.open).not_to include(rejected_invoice)
        end
      end
    end
  
    describe "methods" do
      describe "#fee_amount" do
        it "returns the fee amount based on the invoice amount and fee percentage" do
          invoice = build(:invoice, amount: 1000, fee_percentage: 0.05)
          expect(invoice.fee_amount).to eq(50.0)
        end
      end
  
      describe "#close" do
        context "when given a params hash with a 'closed' status" do
          let(:params) { { status: "closed", fee_closing_date: Date.today } }
  
          it "updates the invoice status, fee closing date, and total fees" do
            invoice = build(:invoice, fee_percentage: 0.1, fee_start_date: Date.today - 7.days, amount: 1000)
            days_open = (Date.today - invoice.fee_start_date).to_i
            expected_fee_total = days_open * invoice.fee_amount
            invoice.close(params)
            expect(invoice.status).to eq("closed")
            expect(invoice.fee_closing_date).to eq(Date.today)
            expect(invoice.total_fees).to eq(expected_fee_total)
          end
        end
  
        context "when given a params hash with a status other than 'closed'" do
          let(:params) { { status: "purchased", fee_closing_date: Date.today } }
  
          it "does not update the invoice status or total fees" do
            invoice = build(:invoice, fee_percentage: 0.1, fee_start_date: Date.today - 7.days, amount: 1000)
            initial_status = invoice.status
            initial_total_fees = invoice.total_fees
            invoice.close(params)
            expect(invoice.status).to eq(initial_status)
            expect(invoice.total_fees).to eq(initial_total_fees)
          end
        end
      end
    end
  end
  