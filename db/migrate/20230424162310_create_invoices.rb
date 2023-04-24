class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :number
      t.decimal :amount
      t.date :due_date
      t.integer :status
      t.decimal :fee_percentage
      t.date :fee_start_date
      t.date :fee_closing_date
      t.decimal :total_fees
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
