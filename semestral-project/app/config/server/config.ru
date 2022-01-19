require 'sinatra'
require 'active_record'

require_relative '../../api/controller/answer_controller'
require_relative '../../api/controller/user_controller'
require_relative '../../api/controller/category_controller'
require_relative '../../api/controller/quiz_controller'

db_config       = YAML::load(File.open('../database/database.yml'))
ActiveRecord::Base.establish_connection(db_config)

use AnswerController
use QuizController
use CategoryController
run UserController