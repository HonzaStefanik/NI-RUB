require_relative '../api/dto/user_dto'
require_relative '../model/user'
require_relative '../model/quiz'
require_relative '../util/dto_validator'

class UserService

  def find_all
    User.all.map do |user|
      user_quizzes = Quiz.joins(:user)
                         .where(users: { id: user.id })
                         .where(quizzes: { user_id: user.id })
      create_return_dto(user, user_quizzes)
    end
  end

  def find_by_id(id)
    user = User.find(id)
    user_quizzes = Quiz.joins(:user)
                       .where(users: { id: id })
                       .where(quizzes: { user_id: id })
    create_return_dto(user, user_quizzes)
  end

  def persist_user(request)
    parsed_request = JSON.parse(request.body.read)
    user_dto = DtoValidator.validate_dto(UserDto, parsed_request)
    user = User.create!(username: user_dto[:username], password: user_dto[:password])
    create_return_dto(user)
  end

  def delete_user(id)
    User.destroy(id)
    nil
  end

  def update_user(id, request)
    parsed_request = JSON.parse(request.body.read)
    user_dto = DtoValidator.validate_dto(UserDto, parsed_request)
    user = User.find(id)
    user.update(
      username: user_dto[:username],
      password: user_dto[:password]
    )
    # a bit ugly redundant db call because (I think) update transforms it into something else
    # and after that I was getting exceptions that the object doesn't have a method called 'id' when trying to convert it
    find_by_id(id)
  end

  private

  def create_return_dto(user, quizzes = {})
    simplified_quizzes = quizzes.map {
      |quiz| { "id" => quiz.id, "name" => quiz.name }
    }
    dto = UserDto.new
    dto.call(
      id: user.id,
      username: user.username,
      quizzes: simplified_quizzes
    ).to_h
  end
end