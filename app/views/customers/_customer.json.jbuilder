json.extract! customer, :id, :email, :name, :password, :rental_charge, :created_at, :updated_at
json.url customer_url(customer, format: :json)
