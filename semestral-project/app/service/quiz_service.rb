require_relative '../api/dto/quiz_dto'
require_relative '../model/quiz'
require_relative '../model/question'
require_relative '../model/category'
require_relative '../util/dto_validator'

class QuizService

  def find_all
    Quiz.all.map do |quiz|
      quiz_categories = quiz.categories
      create_return_dto(quiz, {}, quiz_categories)
    end
  end

  def find_by_id(id)
    quiz = Quiz.find(id)
    quiz_questions = quiz.questions
    quiz_categories = quiz.categories
    create_return_dto(quiz, quiz_questions, quiz_categories)
  end

  def persist_quiz(request)
    parsed_request = JSON.parse(request.body.read)
    quiz_dto = DtoValidator.validate_dto(QuizDto, parsed_request)
    categories = quiz_dto[:category_ids].map { |category_id|
      begin
        Category.find(category_id)
      rescue
        # Ignore - simply skip over categories that weren't found as they are not a crucial part of the quiz
      end
    }.compact
    quiz = Quiz.create!(
      name: quiz_dto[:name],
      description: quiz_dto[:description],
      user_id: quiz_dto[:user_id]
    )
    quiz.categories << categories
    create_return_dto(quiz, {}, categories)
  end

  def delete_quiz(id)
    Quiz.destroy(id)
    nil
  end

  def update_quiz(id, request)
    parsed_request = JSON.parse(request.body.read)
    quiz_dto = DtoValidator.validate_dto(QuizDto, parsed_request)
    quiz = Quiz.find(id)
    categories = quiz_dto[:category_ids].map { |category_id|
      begin
        Category.find(category_id)
      rescue
        # Ignore - simply skip over categories that weren't found as they are not a crucial part of the quiz
      end
    }.compact
    quiz.update(
      name: quiz_dto[:name],
      description: quiz_dto[:description],
      user_id: quiz_dto[:user_id]
    )
    quiz.categories << categories
    create_return_dto(quiz, {}, categories)
  end

  private

  def create_return_dto(quiz, questions = {}, categories = {})
    simplified_questions = questions.map { |question|
      { "id" => question.id, "question" => question.question }
    }
    simplified_categories = categories.map { |category|
      { "id" => category.id, "category" => category.name }
    }
    dto = QuizDto.new
    dto.call(
      name: quiz.name,
      description: quiz.description,
      user_id: quiz.user_id,
      questions: simplified_questions,
      categories: simplified_categories
    ).to_h
  end
end