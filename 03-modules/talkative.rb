module Talkative
  def shout(text)
    output(text.upcase)
  end

  def whisper(text)
    output(text.downcase)
  end

  # caesar cipher implementation taken from 
  # https://stackoverflow.com/questions/41338764/ruby-caesar-cipher-explanation
  def encrypt(text, shift = 3)
    encrypted_text = ''
    text.scan(/./) do |i|
      shift.times { i = i.next } if ('a'..'z').include?(i.downcase)
      encrypted_text << i[-1]
    end
    output(encrypted_text)
  end
end
