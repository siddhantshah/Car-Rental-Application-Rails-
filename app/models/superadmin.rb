class Superadmin < ApplicationRecord

  validates :name, :presence => true
  validates :email, :presence => true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, :presence => true,length: { minimum: 6, maximum: 20 }, on: :create

end
