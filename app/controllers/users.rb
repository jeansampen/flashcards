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

get '/users/new' do
  erb :"users/create"
end

post '/login' do
  session[:user_id] = User.authenticate(params[:user])
  if logged_in?
    redirect '/decks'
  else
    @message = "Username/password combination not found"
    erb :"users/login"
  end
end

post '/users' do
  session[:user_id] = User.create(params[:user]).id
  redirect '/decks'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end
