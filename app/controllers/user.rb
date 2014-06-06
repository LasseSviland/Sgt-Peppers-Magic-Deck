get '/login' do
  if current_user
    return redirect 'http://wwwg.google.no'
  end
  erb :login
end

post '/login' do
  if @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/"
    end
  else
    @error_message = "Wrong login"
    erb :login
  end

end

get '/register' do
  erb :register
end
post '/register' do
  @user = User.new(username: params[:username],password: params[:password])
  if @user.save
    session[:user_id] = @user.id
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
