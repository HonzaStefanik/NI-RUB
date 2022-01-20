require 'dry-validation'
class QuizDto < Dry::Validation::Contract
  json do
    required(:name).value(:string)
    required(:description).value(:string)
    required(:user_id).value(:integer)
  end
end