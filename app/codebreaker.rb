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
      answer<<has_exact_matches(input) if input.length == 4
      # answer<<has_number_matches(input)
      answer.join('')
    end
    # def has_exact_matches(input)
    #   answer=[]
    #   input.split('').each_with_index do |element, index|
    #     if element == secret_array[index]
    #       answer<<"+"
    #     end
    #   end
    #   answer.join("")
    # end
    def has_exact_matches(input)
      answer=['']
      secret_array_mutable = secret_array
      marked_indexes=[]
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
    # def has_number_matches(input)
    #   answer=[]
    #   sa=array_no_exact_matches(@secret_number, input)
    #   sa_const=sa
    #   inpa=array_no_exact_matches(input, input)
    #   inpa.each_with_index do |element, index|
    #     if element != sa_const[index] && sa.include?(element)
    #       answer<<"-"
    #       sa[sa_const.index(element)] = nil
    #     elsif element == sa_const[index]
    #       sa[sa_const.index(element)] = nil
    #     end
    #   end
    #   answer.join("")
    # end
    def has_number_matches(input)
      answer=[]
      mutateable_secret_array=secret_array
      input.split('').each_with_index do |element, index|
        if element != secret_array[index] && mutateable_secret_array.include?(element)
          answer<<"-"
          mutateable_secret_array[secret_array.index(element)] = nil
        elsif element == secret_array[index]
          mutateable_secret_array[secret_array.index(element)] = nil
        end
      end
      answer.join("")
    end
    def secret_array
      @secret_number.split('')
    end
    def array_no_exact_matches(string, input)
      result = string.split('')
      input.split('').each_with_index do |element, index|
        if element == secret_array[index]
          result.delete_at(index)
        end
      end
      result
    end
  end
end
