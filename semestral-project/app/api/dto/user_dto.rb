require 'dry-validation'
require 'dry-types'

class UserDto < Dry::Validation::Contract
  json do
    optional(:id).value(:integer)
    required(:username).value(:string)
    required(:password).value(:string)
    optional(:quizzes).value(:array).each do
      hash do
        required(:id).filled(:integer)
        required(:name).filled(:string)
      end
    end
  end
end