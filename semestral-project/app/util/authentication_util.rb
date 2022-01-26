require 'base64'
require_relative '../model/user'
require_relative '../model/quiz'
require_relative '../model/question'
require_relative '../model/answer'
require_relative '../exception/authentication_exception'

class AuthenticationUtil
  HEADER_MISSING = 'X-Credentials header missing'
  INCORRECT_CREDENTIALS = 'Wrong credentials'
  INVALID_ENTITY = 'Invalid entity'
  private_constant :HEADER_MISSING
  private_constant :INCORRECT_CREDENTIALS
  private_constant :INVALID_ENTITY

  class << self

    def authenticate(data, entity_id, entity_type)
      raise AuthenticationException, HEADER_MISSING if data.nil?
      username, password = get_user_data(data)
      raise AuthenticationException, INCORRECT_CREDENTIALS if username.nil? or password.nil? or entity_id.nil? or entity_type.nil?
      unless User.find_by(username: username)&.authenticate(password)
        raise AuthenticationException, INCORRECT_CREDENTIALS
      end
      user = get_user_from_entity(entity_id, entity_type)
      raise AuthenticationException, INCORRECT_CREDENTIALS if user.username != username
    end

    private

    def get_user_data(data)
      decoded_data = Base64.decode64(data)
      tokens = decoded_data.split(':')
      [tokens[0], tokens[1]]
    end

    def get_user_from_entity(entity_id, entity_type)
      # case statement didn't work for some reason
      return User.find(entity_id) if entity_type == User
      return Quiz.find(entity_id)&.user if entity_type == Quiz
      return Question.find(entity_id)&.quiz.user if entity_type == Question
      return Answer.find(entity_id)&.question.quiz.user if entity_type == Answer
      raise AuthenticationException, INVALID_ENTITY
    end
  end
end