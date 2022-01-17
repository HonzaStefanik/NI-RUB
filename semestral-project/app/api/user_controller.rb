class UserController < Sinatra::Base
  get '/user' do
    "user controller"
  end

  get '/user/:testVar' do
    header_test = request.env['HTTP_USER_AGENT']
    "#{params[:testVar]} - path variable test | #{header_test} - header test"
  end
end