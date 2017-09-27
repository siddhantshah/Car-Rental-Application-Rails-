json.extract! rental, :id, :email, :license, :checkout, :return, :hours, :rental_charge, :status, :created_at, :updated_at
json.url rental_url(rental, format: :json)
