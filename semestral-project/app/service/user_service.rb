require_relative '../api/dto/user_dto'

class UserService
  def persist_user(request)
    parsed_request = JSON.parse(request.body.read)
    user_dto_validation = UserDto.new
    result = user_dto_validation.call(parsed_request)
    return result.to_h if result.success?
    raise ArgumentError.new("Invalid request body #{result.errors.to_h}")
  end
end