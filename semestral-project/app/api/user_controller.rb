require 'json'

before do
  content_type :json
end

class UserController < Sinatra::Base
  get '/user' do
    "user controller"
  end

  get '/user/:testVar' do
    header_test = request.env['HTTP_USER_AGENT']
    "#{params[:testVar]} - path variable test | #{header_test} - header test"
  end

 # # json test
 # post '/user' do
 #   # content_type :json
 #   parsedBody = JSON.parse(request.body.read)
 #   puts "I got some JSON: #{parsedBody.inspect}"
 #   puts "#{parsedBody['test']}"
 #   parsedBody.to_json
 # end
end