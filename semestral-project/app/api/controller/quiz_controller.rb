require 'json'
require 'active_record/errors'
require_relative '../dto/quiz_dto'
require_relative '../../service/quiz_service.rb'
require_relative '../../util/authentication_util'

class QuizController < Sinatra::Base
  before do
    content_type :json
  end
  set :show_exceptions, false

  def initialize(app = nil)
    super
    @quiz_service = QuizService.new
  end

  get '/quiz' do
    @quiz_service.find_all.to_json
  end

  get '/quiz/:id' do
    @quiz_service.find_by_id(params[:id]).to_json
  end

  post '/quiz' do
    parsed_request = JSON.parse(request.body.read)
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      parsed_request['user_id'],
      User
    )
    status 201
    @quiz_service.persist_quiz(parsed_request).to_json end

  delete '/quiz/:id' do
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      Quiz
    )
    @quiz_service.delete_quiz(params[:id]).to_json
  end

  put '/quiz/:id' do
    parsed_request = JSON.parse(request.body.read)
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      Quiz
    )
    @quiz_service.update_quiz(params[:id], parsed_request).to_json
  end

  put '/quiz/:quiz_id/category/:category_id' do
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      Quiz
    )
    @quiz_service.add_category(params[:quiz_id], params[:category_id]).to_json
  end

  delete '/quiz/:quiz_id/category/:category_id' do
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      Quiz
    )
    @quiz_service.remove_category(params[:quiz_id], params[:category_id]).to_json
  end

  error ArgumentError do
    status 400
    env['sinatra.error'].message
  end

  error ActiveRecord::RecordNotFound do
    status 404
    "Quiz with id #{params[:id]} was not found."
  end

  error ActiveRecord::InvalidForeignKey do
    status 404
    "Foreign key doesn't exist."
  end

  error AuthenticationException do
    status 403
    env['sinatra.error'].message
  end
end