get '/decks' do
  #display decks
  erb :'decks/index'
end

get '/decks/:id' do
  #instantiates round
  redirect '/rounds/:id'
end

get '/rounds/:id' do
  #starts game
  #authenticates current_round
  #rediect '/stats' if game_over?
  erb :'cards/display'
end

post '/attempts' do
  # creates an attemtp
  erb :'cards/result'
end

get '/stats' do
  # displays all rounds w/ all stats
  erb :stats
end


