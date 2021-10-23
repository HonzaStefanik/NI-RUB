# frozen_string_literal: true
class MyStruct
  attr_reader :hash

  def initialize(hash = nil)
    @hash = {}
    hash&.each_pair do |key, value|
      add_field(key, value)
    end

  end

  def each_pair(&block)
    return @hash.to_enum unless block_given?

    @hash.each_pair(&block)
    self
  end

  def add_field(key, value)
    key = key.to_sym
    return if singleton_class.method_defined?(key)

    @hash[key] = value
    singleton_class.define_method(key) { @hash[key] }
    singleton_class.define_method("#{key}=") { |x| @hash[key] = x }
  end

  def delete_field(name)
    key = name.to_sym
    begin
      singleton_class.remove_method(key, "#{key}=")
    rescue NameError
      # Ignored
    end
    @hash.delete(key) do
      raise NameError.new("There is no field '#{key}' in #{@hash}", key)
    end
  end

  def []=(name, value)
    add_field(name, value)
  end

  def [](name)
    @hash[name.to_sym]
  end

  def ==(other)
    return false unless other.is_a?(MyStruct)

    @hash == other.hash
  end

  alias eql? ==

  def to_h(&block)
    block_given? ? @hash.to_h(&block) : @hash
  end

  def respond_to_missing?(mid, include_private = false)
    super
  end

  def method_missing(name, *args)
    return nil if args.length.zero?

    if args.length.positive?
      add_field(name.to_s.gsub(/[=:?]/, ''), args[0])
    else
      begin
        super
      rescue NoMethodError
        raise
      end
    end
  end
end

struct1 = MyStruct.new
struct1.name = "John"
p struct1.name

struct1[:age] = 42
p struct1[:age]

struct1.delete_field :age
p struct1.each_pair.to_a

p struct1.to_h

struct2 = MyStruct.new("name" => "John")
struct2[:age] = 42

p struct1 == struct2

struct1[:age] = 42

p struct1 == struct2
