class String
  def constatize
    str_class, const_class = self.split('::'), Object
    str_class.each { |value| const_class = const_class.const_get(value) }
    const_class
  end
end
