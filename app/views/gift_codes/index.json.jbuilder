json.array!(@gift_codes) do |gift_code|
  json.extract! gift_code, :id, :good_id, :code, :activated, :user_id
  json.url gift_code_url(gift_code, format: :json)
end
