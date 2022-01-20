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
    "quiz controller"
  end

  get '/quiz/:id' do

  end

  post '/quiz' do

  end

  delete '/quiz/:id' do

  end

  put '/quiz/:id' do

  end
end