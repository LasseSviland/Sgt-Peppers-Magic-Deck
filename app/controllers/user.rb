get '/login' do
  if current_user
    return redirect '/'
  end
  erb :login
end

post '/login' do
  username = params[:username]
  password = params[:password]
  @user = User.authenticate(username, password)
  if @user
    session[:user_id] = @user.username
    redirect '/'
  else
    @error_message = "Wrong login"
    erb :login
  end

end

get '/register' do
  erb :register
end
post '/register' do
  username = params[:username]
  password = params[:password]
  @user = User.new(username: username,password: password)
  if @user.save
    session[:user_id] = @user.username
    return redirect '/'
  else
    @error_message = @user.errors.messages
    erb :register
  end
end

get '/logout' do
  session.clear
  redirect '/login'
end


get '/' do
  erb :home
end
