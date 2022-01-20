require 'json'
require 'active_record/errors'
require_relative '../dto/quiz_dto'
require_relative '../../service/quiz_service.rb'

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
    @quiz_service.persist_quiz(request).to_json
  end

  delete '/quiz/:id' do

  end

  put '/quiz/:id' do

  end

  error ArgumentError do
    status 400
    env['sinatra.error'].message
  end

  error ActiveRecord::RecordNotFound do
    status 404
    "User with id #{params[:id]} was not found."
  end

  error ActiveRecord::InvalidForeignKey do
    status 404
    "Foreign key doesn't exist."
  end
end