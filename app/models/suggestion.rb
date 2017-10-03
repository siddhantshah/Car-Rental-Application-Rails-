class Suggestion < ApplicationRecord
  validates :location,:presence => true
  validates :manufacturer,:presence => true
  validates :model,:presence => true
  validates :style,:presence => true
end
