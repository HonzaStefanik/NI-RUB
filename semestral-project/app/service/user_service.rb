require_relative '../api/dto/user_dto'
require_relative '../model/user'

class UserService
  def persist_user(request)
    parsed_request = JSON.parse(request.body.read)
    user_dto = validate_dto(parsed_request)
    user = User.create!(username: user_dto[:username], password: user_dto[:password])
    user.to_json
    #return result.to_h if result.success?
    # raise ArgumentError.new("Invalid request body #{result.errors.to_h}")
  end

  private

  def validate_dto(dto)
    user_dto_validation = UserDto.new
    result = user_dto_validation.call(dto)
    return result.to_h if result.success?
    raise ArgumentError.new("Invalid request body #{result.errors.to_h}")
  end
end