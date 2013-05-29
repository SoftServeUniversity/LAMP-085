class Student < ActiveRecord::Base
  attr_accessible :name

  has_many :reports, dependent: :destroy
  has_many :homeworks, through: :reports

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_format_of :name, with: /^[a-z]+\.[a-z]+$/i
end
