require 'json'
require 'active_record/errors'
require_relative '../dto/answer_dto'
require_relative '../../service/answer_service.rb'
require_relative '../../util/authentication_util'

class AnswerController < Sinatra::Base
  before do
    content_type :json
  end
  set :show_exceptions, false

  def initialize(app = nil)
    super
    @answer_service = AnswerService.new
  end

  get '/answer' do
    @answer_service.find_all.to_json
  end

  get '/answer/:id' do
    @answer_service.find_by_id(params[:id]).to_json
  end

  post '/answer' do
    parsed_request = JSON.parse(request.body.read)
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      parsed_request['question_id'],
      Question
    )
    @answer_service.persist_answer(parsed_request).to_json
  end

  delete '/answer/:id' do
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      Answer
    )
    @answer_service.delete_answer(params[:id]).to_json
  end

  put '/answer/:id' do
    parsed_request = JSON.parse(request.body.read)
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      parsed_request['question_id'],
      Question
    )
    @answer_service.update_answer(params[:id], parsed_request).to_json
  end

  error ArgumentError do
    status 400
    env['sinatra.error'].message
  end

  error ActiveRecord::RecordNotFound do
    status 404
    "Answer with id #{params[:id]} was not found."
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