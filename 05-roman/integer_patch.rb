class Integer
  def roman
    RomanConverter.convert(self)
  end

  def to_roman
    Roman.new(self)
  end
end

