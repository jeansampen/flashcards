require 'csv'

deck = Deck.create(subject: "State Capitals")

capitals = CSV.table("db/state_capitals.csv")

capitals.each do |row_data|
  question = "What is the capital of #{row_data[:state]}"
  Card.create(question: question, answer: row_data[:capital], deck_id: deck.id)
end




