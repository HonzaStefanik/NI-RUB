class String
  def number
    RomanConverter.convert(upcase)
  end

  def to_roman
    Roman.new(self)
  end
end

