require 'spec_helper'
require 'codebreaker' # load the file in app/codebreaker.rb

RSpec.describe Codebreaker do
  let(:game)    { Codebreaker::Game.new(output) }
  let(:output)  { double('output').as_null_object } # dont touch this

  context "when I start playing" do
    let(:secret_number) { '1234' }

    it "prints a greeting" do
      expect(output).to receive(:puts).with('Welcome to Codebreaker')

      game.start(secret_number)
    end

    it "asks for the first guess" do
      expect(output).to receive(:puts).with('Enter guess:')

      game.start(secret_number)
    end
  end

  describe "#guess" do
    context "[A] basic set up" do
      it "does not contain a getting started implementation" do
        game.start('1234')
        input = '1234'
        expect(output).not_to receive(:puts).with("you typed '1234'")

        game.guess(input)
      end

      it "gives guidance on wrong formatted guesses" do
        ['333', '55555'].each do |input|
          game.start('1234')
          expect(output).to receive(:puts).with("Try guessing a number with four digits")

          game.guess(input)
        end
      end

      it "does not give guidance on correct formatted guesses" do
        input = '4444'

        game.start('1234')
        expect(output).to_not receive(:puts).with("Try guessing a number with four digits")

        game.guess(input)
      end
    end

    context "[B] with no matches" do
      it "sends a mark with ''" do
        game.start('1234')
        input = '5555'

        expect(output).to receive(:puts).with('')

        game.guess(input)
      end
    end

    context "[C] with 1 match" do
      it "A number match sends a mark with '-'" do
        game.start('1234')
        input = '2555'
        expect(output).to receive(:puts).with('-')

        game.guess(input)
      end

      it "An exact match sends a mark with '+'" do
        game.start('1234')
        input = '1555'
        expect(output).to receive(:puts).with('+')

        game.guess(input)
      end
    end

    context "[D] with 2 matches" do
      it "2 number matches sends a mark with '--'" do
        game.start('1234')
        input = '2355'
        expect(output).to receive(:puts).with('--')

        game.guess(input)
      end

      it "1 number match and 1 exact match (in that order) sends a mark with '+-'" do
        game.start('1234')
        input = '2535'
        expect(output).to receive(:puts).with('+-')

        game.guess(input)
      end

      it "1 exact match and 1 number match (in that order) sends a mark with '+-'" do
        game.start('1234')
        input = '1525'
        expect(output).to receive(:puts).with('+-')

        game.guess(input)
      end
    end

    context "[E] with 3 matches" do
      it "3 exact matches sends a mark with '+++'" do
        game.start('1234')
        input = '1235'
        expect(output).to receive(:puts).with('+++')

        game.guess(input)
      end

      it "3 number matches sends a mark with '---'" do
        game.start('1234')
        input = '5123'
        expect(output).to receive(:puts).with('---')

        game.guess(input)
      end

      it "2 exact matches and 1 number match (in that order) sends a mark with '++-'" do
        game.start('1234')
        input = '1245'
        expect(output).to receive(:puts).with('++-')

        game.guess(input)
      end

      it "1 exact match, 1 number match and 1 exact match (in that order) sends a mark with '++-'" do
        game.start('1234')
        input = '1435'
        expect(output).to receive(:puts).with('++-')

        game.guess(input)
      end

      it "1 number match and 2 exact matches (in that order) sends a mark with '++-'" do
        game.start('1234')
        input = '4235'
        expect(output).to receive(:puts).with('++-')

        game.guess(input)
      end
    end

    context "[F] with 4 matches" do
      it "4 exact matches sends a mark with '++++'" do
        game.start('1234')
        input = '1234'
        expect(output).to receive(:puts).with('++++')

        game.guess(input)
      end

      it "4 number matches sends a mark with '----'" do
        game.start('1234')
        input = '4321'
        expect(output).to receive(:puts).with('----')

        game.guess(input)
      end

      it "1 number match, 2 exact matches, and 1 number match (in that order) sends a mark with '++--'" do
        game.start('1234')
        input = '4231'
        expect(output).to receive(:puts).with('++--')

        game.guess(input)
      end
    end

    context "[G] with ambiguous matches" do
      it "number matches just count once" do
        game.start('1234')
        input = '5111'
        expect(output).to receive(:puts).with('-')

        game.guess(input)
      end

      it "exact match overrules a number match" do
        game.start('1234')
        input = '1111'
        expect(output).to receive(:puts).with('+')

        game.guess(input)
      end
    end
    context "[H] with ambiguous matches and duplicates in secret number" do
      it "secret number has 2 duplicates and guess has 2 number matches" do
        game.start('1214')
        input = '3151'
        expect(output).to receive(:puts).with('--')

        game.guess(input)
      end
      it "secret number has 2 duplicates and guess has 2 exact matches" do
        game.start('1214')
        input = '1315'
        expect(output).to receive(:puts).with('++')

        game.guess(input)
      end
      it "secret number has 2 duplicates and guess has 2 exact matches and a number match" do
        game.start('1214')
        input = '1415'
        expect(output).to receive(:puts).with('++-')

        game.guess(input)
      end
      it "secret number is 1122 and guess is 1112" do
        game.start('1122')
        input = '1112'
        expect(output).to receive(:puts).with('+++')

        game.guess(input)
      end
    end
  end
end
