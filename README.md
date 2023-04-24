<!-- Create a client -->
curl -X POST -H "Content-Type: application/json" -d '{"name": "Finvoice"}' http://localhost:3000/clients

<!-- Create an Invoice -->
curl -X POST -H "Content-Type: application/json" -d '{"number": "INV-123", "amount": 1000, "due_date": "2023-05-01", "status": "created"}' http://localhost:3000/clients/1/invoices

curl -X POST -H "Content-Type: application/json" -d '{"number": "INV-124", "amount": 240.28, "due_date": "2023-05-01", "status": "created"}' http://localhost:3000/clients/1/invoices

curl -X POST -H "Content-Type: application/json" -d '{"number": "INV-125", "amount": 88888.88, "due_date": "2023-05-01", "status": "created"}' http://localhost:3000/clients/1/invoices

<!-- Approve an Invoice -->
curl -X PATCH -H "Content-Type: application/json" -d '{"status": "approved"}' http://localhost:3000/clients/1/invoices/1

<!-- Reject an Invoice -->
curl -X PATCH -H "Content-Type: application/json" -d '{"status": "rejected"}' http://localhost:3000/clients/1/invoices/2

<!-- Purchase an Invoice -->

curl -X PATCH -H "Content-Type: application/json" -d '{"status": "purchased", "fee_percentage": 15, "fee_start_date": "2023-04-28"}' http://localhost:3000/clients/1/invoices/1

<!-- Close an invoice -->

curl -X POST -H "Content-Type: application/json" -d '{"status": "closed", "fee_closing_date": "2023-04-30"}' http://localhost:3000/clients/1/invoices/1/close