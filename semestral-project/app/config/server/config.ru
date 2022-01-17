require 'sinatra'

require_relative '../../api/answer_controller'
require_relative '../../api/user_controller'
require_relative '../../api/category_controller'
require_relative '../../api/quiz_controller'

use AnswerController
use QuizController
use CategoryController
run UserController