require 'dry-validation'
class AnswerDto < Dry::Validation::Contract
  json do
    optional(:id).value(:integer)
    required(:answer).value(:string)
    required(:correct).value(:bool)
    required(:question_id).value(:integer)
  end
end