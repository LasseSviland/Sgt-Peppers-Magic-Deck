get '/login/?' do
  @title="login"
  @header="Login"
  if current_user
    return redirect '/'
  end
  erb :login
end

post '/login/?' do
  @title="login"
  @header="Login"
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

get '/register/?' do
  @title="register"
  @header="register"
  erb :register
end
post '/register/?' do
  @title="register"
  @header="register"
  username = params[:username].downcase
  password = params[:password]
  @user = User.new(username: username,password_hash: password)
  if @user.save
    session[:user_id] = @user.username
    return redirect '/'
  else
    @error_message = @user.errors.messages
    erb :register
  end
end

get '/logout/?' do
  @title="logout"
  @header="logout"
  session.clear
  redirect '/login'
end



get '/profile/?' do
  return redirect "/login" unless logged_in?
  @title="profile"
  @header="profile"
  erb :profile
end
get '/stats/?' do
  return redirect "/login" unless logged_in?
  @title="stats"
  @header="stats"
  erb :stats
end
