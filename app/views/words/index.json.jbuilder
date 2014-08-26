json.array!(@words) do |word|
  json.extract! word, :id, :word_a, :word_b, :know, :user_id
  json.url word_url(word, format: :json)
end
