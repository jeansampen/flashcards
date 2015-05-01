class Round < ActiveRecord::Base

  belongs_to :user
  belongs_to :deck
  has_many   :cards, through: :attempts
  has_many   :attempts
end
