require 'json'
require_relative '../dto/user_dto'
require_relative '../../service/user_service.rb'


class UserController < Sinatra::Base
  before do
    content_type :json
  end
  set :show_exceptions, false

  def initialize(app = nil)
    super
    @user_service = UserService.new
  end

  #def initialize
  #  puts "sinatra constructor test"
  #end

  get '/user' do
    "user controller"
  end

  get '/user/:testVar' do
    header_test = request.env['HTTP_USER_AGENT']
    "#{params[:testVar]} - path variable test | #{header_test} - header test"
  end

  post '/user' do
    @user_service.persist_user(request).to_json
  end

  error ArgumentError do
    status 400
    env['sinatra.error'].message
  end

end