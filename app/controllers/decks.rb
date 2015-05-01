before '/decks*' do
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
  session[:card_ids] = Deck.find(params[:id]).cards.pluck(:id)
  redirect "/rounds/#{round.id}"
end

get '/rounds/:id' do
  if game_over?
    session[:current_card] = nil
    session[:round_id] = nil
    redirect '/stats'
  elsif authenticate_round(params[:id])
    @current_card = get_new_card
    sesson[:current_card] = {id: @current_card.id,
      question: @current_card.question, answer: @current_card.answer}
    @current_subject = Round.find(params[:id]).deck.subject
    erb :'cards/display'
  else
    redirect '/decks'
  end
end

post '/attempts' do
  round = Round.find(session[:round_id])
  @correctness = ()
  round.attempts.create(card_id: sesson[:current_card][:id],
    )
  # creates an attempt
  # @correctness = attempt.correct
  erb :'cards/result'
end

get '/stats' do
  # displays all rounds w/ all stats
  erb :stats
end



