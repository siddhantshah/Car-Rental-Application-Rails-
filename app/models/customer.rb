class Customer < ApplicationRecord
  #attr_accessor :password, :email, :name
  validates :email, :presence => true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :name, :presence => true
  validates :password, :presence => true,length: { minimum: 6, maximum: 20 }, on: :create
end
