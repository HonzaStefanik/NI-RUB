require 'json'
require 'active_record/errors'
require_relative '../dto/category_dto'
require_relative '../../service/category_service.rb'

class CategoryController < Sinatra::Base
  before do
    content_type :json
  end
  set :show_exceptions, false

  def initialize(app = nil)
    super
    @category_service = CategoryService.new
  end

  get '/category' do
    @category_service.find_all.to_json
  end

  get '/category/:id' do
    @category_service.find_by_id(params[:id]).to_json
  end

  post '/category' do
    @category_service.persist_category(request).to_json
  end

  delete '/category/:id' do
    @category_service.delete_category(params[:id]).to_json
  end

  put '/category/:id' do
    @category_service.update_category(params[:id], request).to_json
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
end