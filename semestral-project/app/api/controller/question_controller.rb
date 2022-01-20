class QuestionController < Sinatra::Base
  before do
    content_type :json
  end
  set :show_exceptions, false

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