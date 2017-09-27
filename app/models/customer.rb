class Customer < ApplicationRecord
  #attr_accessor :password, :email, :name

  validates :email, :presence => true
  validates :name, :presence => true
  validates :password, :presence => true
end
