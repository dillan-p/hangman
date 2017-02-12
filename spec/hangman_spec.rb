require "spec_helper"
require "tempfile"
require "hangman"

RSpec.describe Hangman do
  let(:dictionary_file) { File.open("test_file.txt") }

  describe "#word" do
    let(:dictionary_file) { File.open("5desk.txt") }
    let(:hangman) { described_class.new(dictionary_file) }
    subject(:word_length) { hangman.word.length }

    it "can select a word between 5 and 12 characters long" do
      is_expected.to be_within(3.5).of(8.5) #requires last call to be subject for is_expected to be used - look at how Kushal makes his way to that point!!!
    end
  end

  describe "#display" do
    let(:hangman) { described_class.new(dictionary_file) }
    subject(:display) { hangman.display }

    it "displays underscores when no guesses are made" do
      is_expected.to eq("_" * hangman.word.length)
    end

    it "displays letters that have been guessed" do
      first_letter = hangman.word.chars.first
      hangman.guess(first_letter)
      remaining_word_length = hangman.word.length - 1
      is_expected.to eq(first_letter + "_" * remaining_word_length)
    end
  end

  describe "#guess" do
    let(:hangman) { described_class.new(dictionary_file) }

    before { hangman.guess("a") }

    it "raises an exception if letter has already been used for a guess" do
      expect { hangman.guess("a") }.to raise_exception(LetterUsedException)
    end
  end

  describe "#finished?" do
    let(:hangman) { described_class.new(dictionary_file) }
    subject(:finished?) { hangman.finished? }

    it "isn't finished at the start of the game" do
      is_expected.to eq(false)
    end

    it "is finished when the word is guessed" do
      hangman.word.chars { |char| hangman.guess(char) }
      is_expected.to eq(true)
    end
  end
end
