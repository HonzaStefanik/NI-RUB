require 'json'
require 'active_record/errors'
require_relative '../dto/answer_dto'
require_relative '../../service/answer_service.rb'

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
    @answer_service.persist_answer(request).to_json
  end

  delete '/answer/:id' do
    @answer_service.delete_answer(params[:id]).to_json
  end

  put '/answer/:id' do
    @answer_service.update_answer(params[:id], request).to_json
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
end