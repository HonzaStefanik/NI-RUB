require_relative '../api/dto/question_dto'
require_relative '../model/question'
require_relative '../model/answer'
require_relative '../util/dto_validator'

class QuestionService

  def find_all(show_answers = false)
    Question.all.each do |question|
      # todo change to a simplified query and rename relations
      question_answers = Answer.joins(:question)
                         .where(questions: { id: question.id })
                         .where(answers: { question_id: question.id })
      create_return_dto(question, question_answers, show_answers)
    end
  end

  def find_by_id(id, show_answers = false)
    question = Question.find(id)
    # todo change to a simplified query and rename relations
    question_answers = Answer.joins(:question)
                             .where(questions: { id: question.id })
                             .where(answers: { question_id: question.id })
    create_return_dto(question, question_answers, show_answers)
  end

  def persist_question(request)
    parsed_request = JSON.parse(request.body.read)
    question_dto = DtoValidator.validate_dto(QuestionDto, parsed_request)
    question = Question.create!(
      question: question_dto[:question],
      quiz_id: question_dto[:quiz_id]
    )
    create_return_dto(question)
  end

  def delete_question(id)
    Question.destroy(id)
    nil
  end

  def update_question(id, request)
    parsed_request = JSON.parse(request.body.read)
    question_dto = DtoValidator.validate_dto(QuestionDto, parsed_request)
    question = Question.find(id)
    question.update(
      question: question_dto[:question],
      quiz_id: question_dto[:quiz_id]
    )
    create_return_dto(question)
  end

  private

  def create_return_dto(question, answers = {}, show_solution = false)
    simplified_answers = answers.map { |answer|
      if show_solution
        { "id" => answer.id, "answer" => answer.answer}
      else
        { "id" => answer.id, "answer" => answer.answer, "correct" => answer.correct}
      end
    }
    dto = QuestionDto.new
    dto.call(
      id: question.id,
      question: question.question,
      answers: simplified_answers
    ).to_h
  end
end