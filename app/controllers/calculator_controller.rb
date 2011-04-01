class CalculatorController < ApplicationController
  def index
    @calculator = Calculator.new
  end

  def calculate
    @calculator = Calculator.new(params[:value].to_i)
    @history = (params[:history] || '').split('|').first(5)
    if (params[:modify_value] || '') =~ /^(?:-)?\d+$/
      calculation_val = params[:modify_value].to_i
      case params[:method]
      when '+' then @calculator.add(calculation_val);
      when '-' then @calculator.subtract(calculation_val)
      when '*' then @calculator.multiply(calculation_val)
      when '/' then
        begin
          @calculator.divide(calculation_val)
        rescue ZeroDivisionError
          flash[:error] = "You cannot divide by zero"
        end
      when 'C' then
        @calculator.value = 0
        @history = nil
      else @calculator.value
      end
    else
      flash.now[:error] = "This calculator only supports numerical characters.  No decimal points are supported. Please enter a new value."
    end
    @history = ["#{@history.blank? ? '0 ' : ''}#{params[:method]} #{params[:modify_value]}"].concat(@history) unless flash[:error] || (params[:method] == 'C')
    render :action => 'index'
  end
end