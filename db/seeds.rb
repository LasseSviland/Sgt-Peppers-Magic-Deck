beatles_file_path = File.expand_path("../beatles.txt", __FILE__)
File.readlines(beatles_file_path).each do |line|
  entry = line.split("|")
  card = Card.new(question: entry[0], answer: entry[1].chomp, deck_id: 1)
  card.save
end

Deck.create(name: "Beatlemania")