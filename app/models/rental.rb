class Rental < ApplicationRecord
  # has_a :customer
  # has_a :car


  validates :email, :presence => true
  validates :license, :presence => true
  validates :hours, :presence => true
  validates :rental_charge, :presence => true
  validates :status, :presence => true
  validates :checkout, :presence => true
  validates :return, :presence => true

end
