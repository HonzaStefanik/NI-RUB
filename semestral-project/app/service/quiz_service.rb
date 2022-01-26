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

  def persist_quiz(data)
    quiz_dto = DtoValidator.validate_dto(QuizDto, data)
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

  def update_quiz(id, data)
    quiz_dto = DtoValidator.validate_dto(QuizDto, data)
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

  def add_category(quiz_id, category_id)
    quiz = Quiz.find(quiz_id)
    category = Category.find(category_id)
    quiz.categories << category
    quiz.save
    create_return_dto(quiz, quiz.questions, quiz.categories)
  end

  def remove_category(quiz_id, category_id)
    quiz = Quiz.find(quiz_id)
    category = Category.find(category_id)
    quiz.categories.delete(category)
    quiz.save
    create_return_dto(quiz, quiz.questions, quiz.categories)
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
      quiz_id: quiz.id,
      name: quiz.name,
      description: quiz.description,
      user_id: quiz.user_id,
      questions: simplified_questions,
      categories: simplified_categories
    ).to_h
  end
end