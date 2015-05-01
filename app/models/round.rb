class Round < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck
  has_many   :cards, through: :attempts
  has_many   :attempts

  def to_s
    "#{self.updated_at} - #{self.deck.subject} - " +
    "Correct Guesses: #{correct_guesses}, " +
    "Incorrect Guesses: #{incorrect_guesses}, " +
    "#{correct_guesses/(correct_guesses+incorrect_guesses)}% correct"
  end

  def correct_guesses
    self.attempts.where(correct: true).count
  end

  def incorrect_guesses
    self.attempts.where(correct: false).count
  end

end
