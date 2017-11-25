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
      answer = ''
      answer+has_matches(input)
    end
    def has_matches(input)
      answer=[]
      secret_array_mutable = secret_array
      input.split('').each_with_index do |element, index|
        if element == secret_array[index]
          answer<<"+"
          secret_array_mutable[index]="x"
        elsif secret_array_mutable.include?(element)
          answer<<"-"
          secret_array_mutable[secret_array_mutable.index(element)]="x"
        end
      end
      answer.sort.join("")
    end
    def secret_array
      @secret_number.split('')
    end
  end
end
