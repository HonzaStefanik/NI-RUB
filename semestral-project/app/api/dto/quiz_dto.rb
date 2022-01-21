require 'dry-validation'

class QuizDto < Dry::Validation::Contract
  json do
    optional(:quiz_id).value(:integer)
    required(:name).value(:string)
    required(:description).value(:string)
    required(:user_id).value(:integer)
    optional(:questions).value(:array).each do
      hash do
        required(:id).filled(:integer)
        required(:question).filled(:string)
      end
    end
  end
end