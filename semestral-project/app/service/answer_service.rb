require_relative '../api/dto/answer_dto'
require_relative '../model/answer'
require_relative '../util/dto_validator'

class AnswerService

  def find_all
    Answer.all.each do |answer|
      create_return_dto(answer)
    end
  end

  def find_by_id(id)
    create_return_dto(Answer.find(id))
  end

  def persist_answer(request)
    parsed_request = JSON.parse(request.body.read)
    answer_dto = DtoValidator.validate_dto(AnswerDto, parsed_request)
    answer = Answer.create!(
      answer: answer_dto[:answer],
      correct: answer_dto[:correct],
      question_id: answer_dto[:question_id]
    )
    create_return_dto(answer)
  end

  def delete_answer(id)
    Answer.destroy(id)
    nil
  end

  def update_answer(id, request)
    parsed_request = JSON.parse(request.body.read)
    answer_dto = DtoValidator.validate_dto(AnswerDto, parsed_request)
    answer = Answer.find(id)
    answer.update(
      answer: answer_dto[:answer],
      correct: answer_dto[:correct],
      question_id: answer_dto[:question_id]
    )
    create_return_dto(answer)
  end

  private

  def create_return_dto(answer)
    dto = AnswerDto.new
    dto.call(
      id: answer.id,
      answer: answer.answer,
      correct: answer.correct,
      question_id: answer.question_id
    ).to_h
  end
end