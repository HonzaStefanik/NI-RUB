require_relative '../api/dto/quiz_dto'
require_relative '../model/quiz'
require_relative '../model/question'
require_relative '../model/category'
require_relative '../util/dto_validator'

class QuizService

  def find_all
    Quiz.all
  end

  def find_by_id(id)
    Quiz.find(id)
  end

  def persist_quiz(request)
    parsed_request = JSON.parse(request.body.read)
    quiz_dto = DtoValidator.validate_dto(QuizDto, parsed_request)
    Quiz.create!(
      name: quiz_dto[:name],
      description: quiz_dto[:description],
      user_id: quiz_dto[:user_id]
    )
  end
end