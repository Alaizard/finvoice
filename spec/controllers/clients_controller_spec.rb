require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
    describe "GET #index" do
      it "returns http success and JSON response" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
  
      it "returns all clients" do
        clients = create_list(:client, 3)
        get :index
        expect(assigns(:clients)).to match_array(clients)
      end
    end
  
    describe "GET #show" do
      let(:client) { create(:client) }
  
      it "returns http success and JSON response" do
        get :show, params: { id: client.id }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
  
      it "returns the correct client" do
        get :show, params: { id: client.id }
        expect(assigns(:client)).to eq(client)
      end
    end
  
    describe "POST #create" do
      context "with valid parameters" do
        let(:valid_params) { { client: attributes_for(:client) } }
  
        it "creates a new client" do
          expect {
            post :create, params: valid_params
          }.to change(Client, :count).by(1)
        end
  
        it "returns http success and JSON response" do
          post :create, params: valid_params
          expect(response).to have_http_status(:created)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end
  end
  