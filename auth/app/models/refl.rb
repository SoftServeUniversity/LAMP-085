# refl.rb
class Situation

  def initialize description
    @who_is = []
    @who_was = []
    @who_notice = []
    @description = description
    puts "#{description}"
  end

  def is
    @who_is.each do |person|
      puts "person.to_s"
  end

  def was
    
  end

  def notice
    
  end
end

class Person < Situation
  
  def initialize description
    super description
  end

  def doctrina
    
  end

  def purpose
    
  end

  def desision
    
  end

  def move
    
  end
end

x = Person.new "Y is on map"