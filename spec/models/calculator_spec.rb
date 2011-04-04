# encoding: UTF-8
require 'spec_helper'

describe Calculator do
  it 'has a value of zero when created' do
    Calculator.new.value.should == 0
  end

  describe '#add' do
    it 'returns 5 when adding 5 to a new zero calculator' do
      calc = Calculator.new
      calc.add(5).should == 5
      calc.value.should == 5
    end
    it 'returns 10 when adding 5 to a calculator with a value of 5' do
      Calculator.new(5).add(5).should == 10
    end
    it 'returns -5 when adding -5 to a new zero calculator' do
      Calculator.new.add(-5).should == -5
    end
  end

  describe '#subtract' do
    it 'returns -5 when subtracting from a new zero calculator' do
      calc = Calculator.new
      calc.subtract(5).should == -5
      calc.value.should == -5
    end
    it 'returns 10 when subtracting -5 from a calculator with a value of 5' do
      Calculator.new(5).subtract(-5).should == 10
    end
  end

  describe '#mutliply' do
    it 'returns 0 when multiplying by 5 using a new calculator with value 0' do
      calc = Calculator.new
      calc.multiply(5).should == 0
      calc.value.should == 0
    end
    it 'returns 1 when multiplying by 1 using a calculator with a value of 1' do
      Calculator.new(1).multiply(1).should == 1
    end
    it 'returns -10 when multiplying by 2 using a calculator with a value of -5' do
      Calculator.new(-5).multiply(2).should == -10
    end
  end

  describe '#divide' do
    it 'returns 0 when dividing by 5 using a new calculator with value 0' do
      calc = Calculator.new
      calc.divide(5).should == 0
      calc.value.should == 0
    end
    it 'returns 2 when dividing by 5 using a calculator with a value of 10' do
      Calculator.new(10).divide(5).should == 2
    end
    it 'throws a divide by zero exception when dividing by zero' do
      expect { Calculator.new.divide(0).should }.to raise_error(ZeroDivisionError)
    end
  end

  describe '#square root' do
    it 'returns 3 when square rooting a calculator with a value of 9' do
      calc = Calculator.new(9)
      calc.sqrt
      calc.value.should == 3
    end
  end

  describe '#square' do
    it 'returns 16 when squaring a calculator with a value of 4' do
      calc = Calculator.new(4)
      calc.square
      calc.value.should == 16
    end
  end
end