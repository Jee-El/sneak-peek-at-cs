# frozen_string_literal: true

class Knight
  attr_accessor :directions

  def initialize
    @directions = [-1, 1].product([-2, 2]) + [-2, 2].product([-1, 1])
  end
end
