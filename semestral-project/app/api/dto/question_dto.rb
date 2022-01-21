require 'dry-validation'

class QuestionDto < Dry::Validation::Contract
  json do
    optional(:id).value(:integer)
    required(:question).value(:string)
    required(:quiz_id).value(:integer)
    optional(:answers).value(:array).each do
      hash do
        required(:id).filled(:integer)
        required(:answer).filled(:string)
        optional(:correct).filled(:bool)
      end
    end
  end
end