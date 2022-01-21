require 'json'
require 'active_record/errors'
require_relative '../dto/question_dto'
require_relative '../../service/question_service.rb'

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
    @question_service.persist_question(request).to_json
  end

  put '/question/:id' do
    @question_service.update_question(params[:id], request).to_json

  end

  delete '/question/:id' do
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
end