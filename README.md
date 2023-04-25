<!-- Create a client -->
curl -X POST -H "Content-Type: application/json" -d '{"name": "Finvoice"}' http://localhost:3000/clients

<!-- Create an Invoice -->
curl -X POST -H 'Content-Type: multipart/form-data' -F 'invoice[number]=INV-123' -F 'invoice[amount]=1000' -F 'invoice[due_date]=2023-05-01' -F 'invoice[status]=created' -F 'scan=@invoice_scan.pdf' localhost:3000/clients/1/invoices

curl -X POST -H 'Content-Type: multipart/form-data' -F 'invoice[number]=INV-124' -F 'invoice[amount]=150.50' -F 'invoice[due_date]=2023-05-01' -F 'invoice[status]=created' -F 'scan=@invoice_scan_2.png' localhost:3000/clients/1/invoices

curl -X POST -H 'Content-Type: multipart/form-data' -F 'invoice[number]=INV-125' -F 'invoice[amount]=1000' -F 'invoice[due_date]=2023-05-01' -F 'invoice[status]=created' -F 'scan=@invoice_scan_3.pdf' localhost:3000/clients/1/invoices

<!-- Approve an Invoice -->
curl -X PATCH -H "Content-Type: application/json" -d '{"status": "approved"}' http://localhost:3000/clients/1/invoices/1

<!-- Reject an Invoice -->
curl -X PATCH -H "Content-Type: application/json" -d '{"status": "rejected"}' http://localhost:3000/clients/1/invoices/2

<!-- Purchase an Invoice -->

<!-- Note that the percentage is a decimal number. This is so the math operations between it and the amount work more easily than a whole number percentage -->

curl -X PATCH -H "Content-Type: application/json" -d '{"status": "purchased", "fee_percentage": 0.15, "fee_start_date": "2023-04-28"}' http://localhost:3000/clients/1/invoices/1

<!-- Close an invoice -->

curl -X POST -H "Content-Type: application/json" -d '{"status": "closed", "fee_closing_date": "2023-04-30"}' http://localhost:3000/clients/1/invoices/1/close