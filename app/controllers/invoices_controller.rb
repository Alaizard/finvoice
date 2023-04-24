class InvoicesController < ApplicationController::API
	before_action :set_client
	before_action :set_invoice, only: [:show, :update, :destroy, :update_status]

	def index
		@invoices = @client.invoices
		render json: @invoices
	end

	def show
		render json: @invoice
	end

	def create
		@invoice = @client.invoices.new(invoice_params)
		if @invoice.save
			render json: @invoice, status: :created, location: [@client, @invoice]
		else
			render json: @invoice.errors, status: :unprocessable_entity
		end
	end

	def update
		if @invoice.update(invoice_params)
			render json: @invoice
		else
			render json: @invoice.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@invoice.destroy
	end

	def update_status
		if @invoice.update(status: params[:status])
			render json: @invoice
		else
			render json: @invoice.errors, status: :unprocessable_entity
		end
	end

	private

	def set_client
		@client = Client.find(params[:client_id])
	end

	def set_invoice
		@invoice = @client.invoices.find(params[:id])
	end

	def invoice_params
		params.require(:invoice).permit(:number, :amount, :due_date, :status, scans: [])
	end
end
