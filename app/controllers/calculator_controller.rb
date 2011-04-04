class CalculatorController < ApplicationController
  def index
    @calculator = Calculator.new
  end

  def calculate
    @calculator = Calculator.new(params[:value].to_i)
    perform_operation(params[:method], params[:modify_value])
    respond_to do |format|
      format.html { render :action => 'index' }
      format.js { send_json }
    end
  end

  private
    def perform_operation(operation, operation_value)
      @history = (params[:history] || '').split('|').first(5)
      if (operation_value || '') =~ /^(?:-)?\d+$/
        calculation_val = operation_value.to_i
        history_entry = "#{@history.blank? ? '0 ' : ''}#{operation} #{operation_value}"
        case operation
        when '+' then @calculator.add(calculation_val);
        when '-' then @calculator.subtract(calculation_val)
        when '*' then @calculator.multiply(calculation_val)
        when '/' then
          begin
            @calculator.divide(calculation_val)
          rescue ZeroDivisionError
            flash.now[:error] = "You cannot divide by zero"
          end
        when 'C' then
          @calculator.value = 0
          @history = nil
        when 'square root' then
          history_entry = "square root of #{@calculator.value}"
          @calculator.sqrt
        when 'squared' then
          history_entry = "square of #{@calculator.value}"
          @calculator.square
        else @calculator.value
        end
      else
        flash.now[:error] = "This calculator only supports numerical characters.  No decimal points are supported. Please enter a new value."
      end
      @history = ["#{history_entry} = #{@calculator.value}"].concat(@history) unless flash[:error] || (operation == 'C')
    end

    def send_json
      if flash[:error]
        render :status => 400, :json => { :status => 'error', :message => flash[:error] }
      else
        render :json => {
          :value => @calculator.value,
          :history => @history
        }
      end
    end
end