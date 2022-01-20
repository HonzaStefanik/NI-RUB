require 'json'
require 'active_record/errors'
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

  get '/user' do
    @user_service.find_all.to_json
  end

  get '/user/:id' do
    @user_service.find_by_id(params[:id]).to_json
  end

  post '/user' do
    @user_service.persist_user(request).to_json
  end

  # TODO add some form of auth to allow only the user himself to delete his record (decide later on token vs credentials)
  delete '/user/:id' do
    @user_service.delete_user(params[:id])
  end

  put '/user/:id' do
    @user_service.update_user(params[:id], request).to_json
  end


  error ArgumentError do
    status 400
    env['sinatra.error'].message
  end

  error ActiveRecord::RecordNotFound do
    status 404
    "User with id #{params[:id]} was not found."
  end

end