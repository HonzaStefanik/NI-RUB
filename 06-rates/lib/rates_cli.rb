require 'thor'
require 'rates'

class RatesCli < Thor
  def initialize
    @convertor = Rates.new
  end

  # run the program
  desc 'start program', 'starts the program'

  def start(argv = [])
    # print help if no arguments are given or if -h flag is present
    if argv.length.zero? || (argv.length == 1 && (argv[0] == '-h' || argv[0] == '--help'))
      print_help
      return
    end

    # exactly 3 arguments are expected
    return error_print_help if argv.length != 3

    amount = argv[0].to_f
    in_currency_ = argv[1]
    out_currency = argv[2]

    puts @convertor.convert(amount, in_currency_, out_currency)
  end

  private

  def print_help
    puts 'Usage: rates <amount> <input_currency> <output_currency>'
    puts 'Options:'
    puts '  -h, --help'
  end

  def error_print_help
    puts 'Invaid input'
    print_help
  end
end