# frozen_string_literal: true
module Validations
  ARMS_EXCEEDED = 'Exceeded maximum amount of arms, maximum of 10 is allowed'
  private_constant :ARMS_EXCEEDED

  def add_arms(*arms)
    raise StandardError, ARMS_EXCEEDED if @arms.length + arms.length > 10

    super(*arms)
  end
end
