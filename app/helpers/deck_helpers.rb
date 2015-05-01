helpers do

  def current_subject
    # !this isn't tested
    Round.find(session[:round_id]).deck.name
  end

end
