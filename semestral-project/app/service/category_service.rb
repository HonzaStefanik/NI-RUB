require_relative '../api/dto/category_dto'
require_relative '../model/quiz'
require_relative '../util/dto_validator'

class CategoryService

  def find_all
    Category.all.each do |category|
      create_return_dto(category)
    end
  end

  def find_by_id(id)
    create_return_dto(Category.find(id))
  end

  def persist_category(request)
    parsed_request = JSON.parse(request.body.read)
    category_dto = DtoValidator.validate_dto(CategoryDto, parsed_request)
    category = Category.create!(
      name: category_dto[:name],
      description: category_dto[:description]
    )
    create_return_dto(category)
  end

  def delete_category(id)
    Category.destroy(id)
    nil
  end

  def update_category(id, request)
    parsed_request = JSON.parse(request.body.read)
    category_dto = DtoValidator.validate_dto(CategoryDto, parsed_request)
    category = Category.find(id)
    category.update(
      name: category_dto[:name],
      description: category_dto[:description]
    )
    create_return_dto(category)
  end

  private

  def create_return_dto(category)
    puts category.attributes
    dto = CategoryDto.new
    dto.call(
      id: category.id,
      name: category.name,
      description: category.description
    ).to_h
  end
end