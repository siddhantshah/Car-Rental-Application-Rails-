class Car < ApplicationRecord
  validates :license, :presence => true
  validates :manufacturer,:presence => true,:case_sensitive => false
  validates :model,:presence => true,:case_sensitive => false
  validates :rate,:presence => true
  validates :style,:presence => true,:case_sensitive => false
  validates :location,:presence => true,:case_sensitive => false
  validates :status,:presence => true
end
