require_relative '../api/dto/user_dto'
require_relative '../model/user'
require_relative '../model/quiz'

class UserService

  def find_all_users
    User.all
  end

  def find_by_id(id)
    User.find(id)
  end

  def persist_user(request)
    parsed_request = JSON.parse(request.body.read)
    user_dto = validate_dto(parsed_request)
    User.create!(username: user_dto[:username], password: user_dto[:password])
  end

  def delete_user(id)
    User.destroy(id)
    nil
  end

  def update_user(id, request)
    parsed_request = JSON.parse(request.body.read)
    user_dto = validate_dto(parsed_request)
    user = find_by_id(id)
    user.update(
      username: user_dto[:username],
      password: user_dto[:password]
    )
    user
  end

  private

  def validate_dto(dto)
    user_dto_validation = UserDto.new
    result = user_dto_validation.call(dto)
    return result.to_h if result.success?
    raise ArgumentError.new("Invalid request body #{result.errors.to_h}")
  end
end