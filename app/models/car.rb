class Car < ApplicationRecord
  validates :license, :presence => true
  validates :manufacturer,:presence => true
  validates :model,:presence => true
  validates :rate,:presence => true
  validates :style,:presence => true
  validates :location,:presence => true
  validates :status,:presence => true
end
