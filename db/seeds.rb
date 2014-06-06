File.readlines("/Users/apprentice/Desktop/Sgt-Peppers-Magic-Deck/db/beatles.txt").each do |line|
  entry = line.split("|")
  card = Card.new(question: entry[0], answer: entry[1].chomp, deck_id: 1)
  card.save
end

Deck.create(name: "Beatlemania")
