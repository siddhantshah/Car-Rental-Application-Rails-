class Rental < ApplicationRecord
  # has_a :customer
  # has_a :car


  validates :email, :presence => true
  validates :license, :presence => true
  validates :hours, :presence => true
  validates :rental_charge, :presence => true
  validates :status, :presence => true
  validates :checkout, :presence => true
  #validates_inclusion_of :checkout, :in => Date.today..(Date.today+7.days)
  #validates_date :checkout, after: lambda { (DateTime.now)}, before: lambda { (DateTime.now) + 7.days }
  validates :return, :presence => true

end
