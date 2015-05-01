class Round < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck
  has_many   :cards, through: :attempts
  has_many   :attempts

  def correct_guesses
    self.attempts.where(correct: true).count
  end

  def incorrect_guesses
    self.attempts.where(correct: false).count
  end

  def to_s
    correct = correct_guesses
    incorrect = incorrect_guesses
    total = correct+incorrect
    output_string = "#{self.updated_at} - #{self.deck.subject}"
    if total > 0
      percentage = (100*correct.to_f/(correct+incorrect)).round(2)
      return output_string +
        " - Correct Guesses: #{correct}, " +
        "Incorrect Guesses: #{incorrect}, " +
        "#{percentage}% correct"
    else
      return output_string + " - no guesses made"
    end
  end

end
