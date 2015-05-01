before do
  redirect '/login' unless logged_in?
end

get '/decks' do
  #display decks
  @decks = Deck.all
  erb :'decks/index'
end

get '/decks/:id' do
  round = Round.create(deck_id: params[:id],
    user_id: session[:user_id])
  session[:round_id] = round.id
  session[:card_ids] = Deck.find(params[:id]).cards.map{|card| card.id}
  redirect "/rounds/#{round.id}"
end

get '/rounds/:id' do
  if game_over?
    redirect '/stats'
  elsif authenticate_round(params[:id])
    @current_card = get_new_card
    @current_subject = Round.find(params[:id]).deck.subject
    erb :'cards/display'
  else
    redirect '/decks'
  end
end

post '/attempts' do
  # creates an attempt
  # @correctness = attempt.correct
  erb :'cards/result'
end

get '/stats' do
  # displays all rounds w/ all stats
  erb :stats
end



