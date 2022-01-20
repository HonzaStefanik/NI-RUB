require_relative '../api/dto/user_dto'
require_relative '../model/user'
require_relative '../model/quiz'
require_relative '../util/dto_validator'

class UserService

  def find_all
    User.all
  end

  def find_by_id(id)
    User.find(id)
  end

  def persist_user(request)
    parsed_request = JSON.parse(request.body.read)
    user_dto = DtoValidator.validate_dto(UserDto, parsed_request)
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
end