class LetterUsedException < StandardError; end

class Hangman
  attr_reader :word

  def initialize(file)
    @word = select_random_word(file)
    @guesses = []
  end

  def display
    @word.chars.map { |c| @guesses.include?(c) ? c : "_" }.join("")
  end

  def guess(letter)
    raise LetterUsedException if @guesses.include?(letter)
    @guesses << letter
  end

  def finished?
    @word == display
  end

  private

  def select_random_word(file)
    #x.map { |s| s.slice("b") } need to pass in as a block if using a method that requires a paramter
    file.readlines.map(&:strip).select do |word|
      word.size >= 5 && word.size <= 12
    end.shuffle.first
  end
end
