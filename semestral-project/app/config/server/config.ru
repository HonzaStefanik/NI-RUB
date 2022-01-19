require 'sinatra'

require_relative '../../api/controller/answer_controller'
require_relative '../../api/controller/user_controller'
require_relative '../../api/controller/category_controller'
require_relative '../../api/controller/quiz_controller'

use AnswerController
use QuizController
use CategoryController
run UserController