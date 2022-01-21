require_relative '../api/dto/quiz_dto'
require_relative '../model/quiz'
require_relative '../model/question'
require_relative '../model/category'
require_relative '../util/dto_validator'

class QuizService

  def find_all
    create_return_dto(Quiz.all)
  end

  def find_by_id(id)
    quiz = Quiz.find(id)
    # todo rename relations to plural so it looks correct
    quiz_questions = quiz.question
    create_return_dto(quiz, quiz_questions)
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

  def delete_quiz(id)
    Quiz.destroy(id)
    nil
  end

  def update_quiz(id, request)
    parsed_request = JSON.parse(request.body.read)
    quiz_dto = DtoValidator.validate_dto(QuizDto, parsed_request)
    quiz = Quiz.find(id)
    quiz.update(
      name: quiz_dto[:name],
      description: quiz_dto[:description],
      user_id: quiz_dto[:user_id]
    )
    quiz
  end

  private
  def create_return_dto(quiz, questions = {})
    simplified_questions = questions.map { |question|
        { "id" => question.id, "question" => question.question}
    }
    dto = QuizDto.new
    dto.call(
      name: quiz.name,
      description: quiz.description,
      user_id: quiz.user_id,
      questions: simplified_questions
    ).to_h
  end
end