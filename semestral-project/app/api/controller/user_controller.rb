require 'json'
require 'active_record/errors'
require_relative '../dto/user_dto'
require_relative '../../service/user_service.rb'
require_relative '../../util/authentication_util'

class UserController < Sinatra::Base
  before do
    content_type :json
  end
  set :show_exceptions, false

  def initialize(app = nil)
    super
    @user_service = UserService.new
  end

  get '/user' do
    @user_service.find_all.to_json
  end

  get '/user/:id' do
    @user_service.find_by_id(params[:id]).to_json
  end

  post '/user' do
    parsed_request = JSON.parse(request.body.read)
    @user_service.persist_user(parsed_request).to_json
  end

  delete '/user/:id' do
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      User
    )
    @user_service.delete_user(params[:id])
  end

  put '/user/:id' do
    AuthenticationUtil.authenticate(
      request.env['HTTP_X_CREDENTIALS'],
      params[:id],
      User
    )
    parsed_request = JSON.parse(request.body.read)
    @user_service.update_user(params[:id], parsed_request).to_json
  end

  error ArgumentError do
    status 400
    env['sinatra.error'].message
  end

  error ActiveRecord::RecordNotFound do
    status 404
    "User with id #{params[:id]} was not found."
  end

  error ActiveRecord::RecordNotUnique do
    status 400
    "Username already exists."
  end

  error AuthenticationException do
    status 403
    env['sinatra.error'].message
  end
end