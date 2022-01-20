require 'dry-validation'
class CategoryDto < Dry::Validation::Contract
  json do
    optional(:id).value(:integer)
    required(:name).value(:string)
    required(:description).value(:string)
  end
end