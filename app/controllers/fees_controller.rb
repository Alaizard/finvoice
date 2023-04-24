class FeesController < ApplicationController::API
	before_action :set_client
	before_action :set_invoice
	before_action :set_fee, only: [:show, :update, :destroy]

	def index
		@fees = @invoice.fees
		render json: @fees
	end

	def create
		@fee = @invoice.fees.new(amount: fee_amount, date: Date.today)
		if @fee.save
			render json: @fee, status: :created, location: [@client, @invoice, @fee]
		else
			render json: @fee.errors, status: :unprocessable_entity
		end
	end

	private
	
	def set_client
		@client = Client.find(params[:client_id])
	end
	
	def set_invoice
		@invoice = @client.invoices.find(params[:invoice_id])
	end
	
	def set_fee
		@fee = @invoice.fees.find(params[:id])
	end
end