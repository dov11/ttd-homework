class Codebreaker
  class Game
    attr_reader :output

    def initialize(output)
      @output = output
    end

    def start(secret_number)
      @secret_number = secret_number

      output.puts "Welcome to Codebreaker"
      output.puts "Enter guess:"
    end

    def guess(input)
      output.puts answer(input)
    end
    def answer(input)
      return "Try guessing a number with four digits" if input.length != 4
      answer = ['']
      number_of_exact_matches(input).times {|i| answer<<"+"}
      number_of_misplaced_matches(input).times {|i| answer<<"-"}
      answer.join('')
    end
    def number_of_exact_matches(input)
      i_array = input.split('')
      i_array
      .select{|element| i_array.index(element)==secret_array.index(element)}
      .length
    end
    def number_of_misplaced_matches(input)
      i_array = input.split('')
      i_array
      .select{|element| i_array.index(element)!=secret_array.index(element) && @secret_number.include?(element)}
      .length
    end
    def secret_array
      @secret_number.split('')
    end

  end
end
