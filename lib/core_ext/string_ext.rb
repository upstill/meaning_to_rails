class String

  def extensions_to_classes
    split('.').inject([]) { |classes, substr|
      classes << (classes.present? ? "#{classes.last}-#{substr.downcase}" : substr.downcase)
    }.join ' '
  end
  
  def extensions_to_selector
    extensions_to_classes.gsub /\s+\b/, '.'
  end

  def to_boolean
    %w{ true TRUE t T 1 }.include? self
  end

  # Return nil if the string is empty. Also defined on NilClass, so empty strings and nil both return nil (or default)
  def if_present default=nil
    self.empty? ? default : self
  end

  def with_article
    ((%w{ a e i o u }.include? self[0]) ? 'an ' : 'a ') + self
  end
end