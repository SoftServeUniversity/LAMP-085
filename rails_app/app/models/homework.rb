class Homework < ActiveRecord::Base
  attr_accessible :description, :language, :title

  has_many :reports, :autosave => true
  has_many :students, :through => :reports

  validates_presence_of :title, :language

  validates_format_of :title, with: /^[a-z\.]+$/i
  validates_format_of :language, with: /^ruby|python$/i
end
