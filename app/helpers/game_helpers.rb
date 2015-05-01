helpers do

  def game_over?
    session[:card_ids].length == 0
  end

  def authenticate_round(round_id)
    session[:round_id] == round_id.to_i
  end

end
