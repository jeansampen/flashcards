helpers do

  def current_subject
    # !this isn't tested
    Round.find(session[:round_id]).deck.name
  end

  def get_new_card
    Card.find(session[:card_ids].shuffle.pop)
  end

end
