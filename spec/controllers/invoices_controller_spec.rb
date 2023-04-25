require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
    let(:client) { FactoryBot.create(:client) }
    let(:invoice) { FactoryBot.create(:invoice, client: client, status: 'created') }
    let(:valid_attributes) { FactoryBot.attributes_for(:invoice) }
    let(:invalid_attributes) { { amount: nil } }
  
    describe "POST #create" do
      context "with valid params" do
        it "creates a new invoice" do
          expect {
            post :create, params: { client_id: client.id, invoice: valid_attributes }
          }.to change(Invoice, :count).by(1)
        end
  
        it "returns a JSON response with the new invoice" do
          post :create, params: { client_id: client.id, invoice: valid_attributes }
          expect(response).to have_http_status(:created)
          expect(response.content_type).to eq('application/json; charset=utf-8')
          expect(response.location).to eq(client_invoice_url(client, Invoice.last))
        end
      end
  
      context "with invalid params" do
        it "returns a JSON response with errors" do
          post :create, params: { client_id: client.id, invoice: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end
  
    describe "PATCH #update" do
      context "with valid params" do
        it "updates the requested invoice" do
          patch :update, params: { client_id: client.id, id: invoice.to_param, invoice: valid_attributes }
          invoice.reload
          expect(invoice).to be_valid
        end
  
        it "returns a JSON response with the updated invoice" do
          patch :update, params: { client_id: client.id, id: invoice.to_param, invoice: valid_attributes }
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
  
      context "with invalid params" do
        it "returns a JSON response with errors" do
          patch :update, params: { client_id: client.id, id: invoice.to_param, invoice: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end
  
    describe "POST #close_invoice" do
      context "with invalid params" do
        it "returns a JSON response with errors" do
            post :close_invoice, params: { client_id: client.id, invoice_id: invoice.id, invoice: { status: 'purchased' } }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to eq('application/json; charset=utf-8')
          end
        end
    end
end        