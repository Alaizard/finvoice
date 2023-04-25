class InvoicesController < ActionController::API
	before_action :set_client
	before_action :set_invoice, except: [:create, :close_invoice]

	def create
		@invoice = @client.invoices.new(invoice_params)
		if @invoice.save
			render json: @invoice, status: :created, location: [@client, @invoice]
		else
			render json: @invoice.errors, status: :unprocessable_entity
		end
	end

	def update
		if verify_status && @invoice.update(invoice_params)
			render json: @invoice, status: 200
		else
			render json: @invoice.errors, status: :unprocessable_entity
		end
	end

	def close_invoice
		@invoice = @client.invoices.open.find(params[:invoice_id])
		if verify_status && @invoice.close(invoice_params)
			render json: @invoice, status: 200
		else
			render json: @invoice.errors, status: :unprocessable_entity
		end
	end

	private

	def verify_status
		case invoice_params['status']
		when 'created'
			true
		when 'approved'
			return true if @invoice.created?
		when 'rejected'
			return true if @invoice.created?
		when 'purchased'
			return true if @invoice.approved?
		when 'closed'
			return true if @invoice.purchased?
		else
			false
		end
	end

	def set_client
		@client = Client.find(params[:client_id])
	end

	def set_invoice
		@invoice = @client.invoices.open.find(params[:id])
	end

	def invoice_params
		params.require(:invoice).permit(:number, :amount, :due_date, :status, :fee_percentage, :fee_start_date, :fee_closing_date, :scan)
	end
end
