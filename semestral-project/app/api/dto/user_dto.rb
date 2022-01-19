require 'dry-validation'
class UserDto < Dry::Validation::Contract
  json do
    required(:username).value(:string)
    required(:password).value(:string)
  end
end