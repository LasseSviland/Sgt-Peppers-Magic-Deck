beatles_file_path = File.expand_path("../beatles.txt", __FILE__)
File.readlines(beatles_file_path).each do |line|
  entry = line.split("|")
  card = Card.new(question: entry[0], answer: entry[1].chomp, deck_id: 1)
  card.save
end
Deck.create(name: "Beatles")

states_file_path = File.expand_path("../states.txt", __FILE__)
File.readlines(states_file_path).each do |line|
  entry = line.split(",")
  question = "What is the capital of the state #{entry[0]}"
  card = Card.new(question: question, answer: entry[2].chomp, deck_id: 2)
  card.save
end
Deck.create(name: "States Capitals")

contries_file_path = File.expand_path("../countries.txt", __FILE__)
File.readlines(contries_file_path).each do |line|
  entry = line.split(";")
  question = "What is the capital of the country #{entry[0].chomp}"
  card = Card.new(question: question, answer: entry[8].chomp, deck_id: 3)
  card.save
end
Deck.create(name: "World Capitals")
