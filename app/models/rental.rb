class Rental < ApplicationRecord
  # has_a :customer
  # has_a :car


  validates :email, :presence => true
  validates :license, :presence => true,length: { minimum: 7, maximum: 7 }, on: :create
  validates :hours, :presence => true
  validates :rental_charge, :presence => true
  validates :status, :presence => true
  validates :checkout, :presence => true
  #def checkout
   # if checkout.present? && checkout > DateTime.today && checkout <DateTime.today+7.days
    #  errors.add(:checkout, "You can reserve for a timeline upto next 7 days only")
    #end
    #end
  validates :return, :presence => true

end
