require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"

get("/") do
  erate_list_url="https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_KEY") 
  # erate_convert_url="https://api.exchangerate.host/convert?from=" + currency_o + "&to=" currency_d "&amount=1&access_key=" + ENV.fetch("EXCHANGE_KEY")"
  #pp erate_list_url
  erate_list_api=HTTP.get(erate_list_url).to_s
  #pp erate_list_api
  parse_erate_l_body = JSON.parse(erate_list_api)
  # pp parse_erate_l_body.keys
  currencies=parse_erate_l_body.fetch("currencies")
  @list_currencies = currencies.keys
  # pp currencies.class
  erb(:home)
end

get("/:currency_o") do
  @currency_o=params.fetch("currency_o")
  erb(:origin)
end
# get(":currency_o/:currency_d") do
#   @currency_o=params.fetch("currency_o")
#   @currency_d=params.fetch("currency_d")
#   erb(:conversion)
# end
