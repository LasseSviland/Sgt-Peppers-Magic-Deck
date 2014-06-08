get '/' do
  @title="Play"
  @header="Play"
  @decks = Deck.all
  erb :home
end


get '/round/:deck_id/new/?' do
	@title="New game"
	round = Round.find_by(deck:params[:deck_id], user:current_user)
	if round
		return redirect "/round/#{round.id}"
	else
		deck = Deck.find_by(id: params[:deck_id])
		user = current_user
		card = Card.where(deck: deck)
		round = Round.create(deck: deck, user:user)
		card.each do |ca|
			Guess.create(round:round, card:ca, guessed: false)
		end
		redirect "/round/#{round.id}"
	end
end



get '/round/:round_id/?' do
	@round = Round.find_by(id: params[:round_id])
	if @round.finished
		return erb :round_stats
	else
		guesses = Guess.where(round: params[:round_id], guessed: false).order('tries ASC')
#		@guess_count = Guess.where(round: params[:round_id]).length
		@guess= guesses.first
		erb :game
	end
end

post '/round/:round_id/?' do
	user_guess = params[:guess]
	card = Card.find_by(id: params[:card_id])
	@round = Round.find_by(id:params[:round_id])
	@guess = Guess.find_by(round: params[:round_id], card: card)
	if user_guess == card.answer
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


#
#	@round = Round.find_by(deck:params[:deck_id], user:current_user)
#	if @round.finished
#		return erb :"round_stats"
#	else
#		@guesses = Guess.where(round: params[:round_id], guessed: false).order('tries ASC')
#		@guess_count = Guess.where(round: params[:round_id]).length
#		erb :game
#	end
#end