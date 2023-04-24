class Invoice < ApplicationRecord
  belongs_to :client
  has_one_attached :scan
  validates :number, presence: true, uniqueness: true

  enum status: %i[ created approved rejected purchased closed ]

  scope :open, -> {where.not(status: 'rejected')}

  def fee_amount
    self.amount * (self.fee_percentage / 100)
  end

  def close(params)
    return unless params[:status] == 'closed'

    days_open = calculate_days_open(self.fee_start_date, params[:fee_closing_date])
    fee_total = calculate_total_fees(days_open)
    
    self.fee_closing_date = params[:fee_closing_date]
    self.total_fees = fee_total
    self.status = 'closed'
    self.save!
  end

  private

  def calculate_days_open(start_date, end_date)
    (start_date.to_date - end_date.to_date).to_i
  end

  def calculate_total_fees(days_open)
    fee_amount * days_open
  end
  
end
