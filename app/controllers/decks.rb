before '/decks*' do
  redirect '/login' unless logged_in?
end

get '/decks' do
  #display decks
  @decks = Deck.all
  erb :'decks/index'
end

get '/decks/:id' do
  round = Round.create(deck_id: params[:id], user_id: session[:user_id])
  session[:round_id] = round.id
  session[:card_ids] = Deck.find(params[:id]).cards.pluck(:id).shuffle
  redirect "/rounds/#{round.id}"
end

get '/rounds/:id' do
  redirect '/decks' unless authenticate_round(params[:id])
  if game_over?
    session[:current_card] = nil
    session[:round_id] = nil
    redirect '/stats'
  else
    puts "card count: #{session[:card_ids].count}"
    @current_card = get_new_card
    session[:current_card] = {id: @current_card.id,
      question: @current_card.question, answer: @current_card.answer}
    @current_subject = Round.find(session[:round_id]).deck.subject
    erb :'cards/display'
  end
end

post '/attempts' do
  @correctness = params[:answer] == session[:current_card][:answer]
  round = Round.find(session[:round_id])
  round.attempts.create(
    card_id: session[:current_card][:id],
    round_id: session[:round_id],
    correct: @correctness,
    submission: params[:answer] )
  @current_subject = Round.find(session[:round_id]).deck.subject
  erb :'cards/results'
end

get '/stats' do
  @rounds = Round.all.order(updated_at: :desc)
  erb :'stats/show'
end



