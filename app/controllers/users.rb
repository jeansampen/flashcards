get '/' do
  redirect '/login'
end

get '/login' do
  if logged_in?
    redirect '/decks'
  else
    erb :"users/login"
  end
end

