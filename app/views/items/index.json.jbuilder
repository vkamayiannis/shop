json.array!(@items) do |item|
  json.extract! item, :id, :code, :description, :price
  json.url item_url(item, format: :json)
end
