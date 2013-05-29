class Report < ActiveRecord::Base
  attr_accessible :homework_id, :quality, :ratio, :student_id, :time
  belongs_to :student
  belongs_to :homework

  validates_presence_of :quality, :ratio, :time

  validates_numericality_of :quality, :ratio, {
    greater_than_or_equal_to: 0.00,
    less_than_or_equal_to: 100.00
  }
  validates_numericality_of :time, greater_than: 0.00 
end
