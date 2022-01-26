require 'json'
require 'active_record/errors'
require_relative '../dto/question_dto'
require_relative '../../service/question_service.rb'
require_relative '../../util/authentication_util'

class QuestionController < Sinatra::Base
  before do
    content_type :json
  end
  set :show_exceptions, false

  def initialize(app = nil)
    super
    @question_service = QuestionService.new
  end

  get '/question' do
    @question_service.find_all(params[:show_answers]).to_json
  end

  get '/question/:id' do
    @question_service.find_by_id(
      params[:id],
      params[:show_answers]
    ).to_json
  end

  post '/question' do
    parsed_request = JSON.parse(request.body.read)
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      parsed_request['quiz_id'],
      Quiz
    )
    @question_service.persist_question(parsed_request).to_json
  end

  put '/question/:id' do
    parsed_request = JSON.parse(request.body.read)
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      Question
    )
    @question_service.update_question(params[:id], parsed_request).to_json
  end

  delete '/question/:id' do
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      Question
    )
    @question_service.delete_question(params[:id])
  end

  error ArgumentError do
    status 400
    env['sinatra.error'].message
  end

  error ActiveRecord::RecordNotFound do
    status 404
    "Question with id #{params[:id]} was not found."
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