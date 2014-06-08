get '/' do
	return redirect "/login" unless logged_in?
  @title="Play"
  @header="Play"
  @decks = Deck.all
  erb :home
end
get '/round/:deck_id/rounds/?' do
	return redirect "/login" unless logged_in?
	@deck = Deck.find_by(id: params[:deck_id])
	@unfinished_rounds = Round.where(deck:params[:deck_id], user:current_user, finished: false)
	@finished_rounds = Round.where(deck:params[:deck_id], user:current_user, finished: true)
	erb :rounds
end

get '/round/:deck_id/new/?' do
	return redirect "/login" unless logged_in?
	@title="New game"
	unfinished_rounds = Round.where(deck:params[:deck_id], user:current_user, finished: false)
	if unfinished_rounds.length > 0
		return redirect "/round/#{params[:deck_id]}/rounds"
	else
		deck = Deck.find_by(id: params[:deck_id])
		user = current_user
		card = Card.where(deck: deck).sample(10)
		round = Round.create(deck: deck, user:user)
		card.each do |ca|
			Guess.create(round:round, card:ca, guessed: false)
		end
		redirect "/round/#{round.id}"
	end
end


get '/round/:round_id/?' do
	return redirect "/login" unless logged_in?
	@round = Round.find_by(id: params[:round_id])
	if @round.finished
		return redirect "/round/#{@round.deck.id}/rounds/"
	else
		guesses = Guess.where(round: params[:round_id], guessed: false).order('tries ASC')
#		@guess_count = Guess.where(round: params[:round_id]).length
		@guess= guesses.first
		erb :game
	end
end

post '/round/:round_id/?' do
	return redirect "/login" unless logged_in?
	user_guess = params[:guess]
	card = Card.find_by(id: params[:card_id])
	@round = Round.find_by(id:params[:round_id])
	@guess = Guess.find_by(round: params[:round_id], card: card)
	if user_guess.downcase == card.answer.downcase
		@guess.guessed = true
		@guess.tries += 1
	else
		@guess.tries += 1
	end
	@guess.save
	@guesses = Guess.where(round: params[:round_id], guessed:false).length
	if @guesses > 0
		erb :answer
	else
		@round.finished = true
		@round.save
		redirect "/round/#{@round.id}"
	end
end
