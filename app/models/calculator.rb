class Calculator
  attr_accessor :value

  def initialize(initial_value = 0)
    @value = initial_value
  end

  def add(val)
    @value = @value + val
  end

  def subtract(val)
    @value = @value - val
  end

  def multiply(val)
    @value = @value * val
  end

  def divide(val)
    @value = @value / val
  end

  def sqrt
    @value = Math.sqrt(@value).to_i
  end

  def square
    @value = @value ** 2
  end
end