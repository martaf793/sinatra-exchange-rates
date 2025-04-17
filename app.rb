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
  @currency_o=params.fetch("currency_o").upcase
  erate_list_url="https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_KEY") 
  erate_list_api=HTTP.get(erate_list_url).to_s
  parse_erate_l_body = JSON.parse(erate_list_api)
  currencies=parse_erate_l_body.fetch("currencies")
  @list_currencies = currencies.keys
  erb(:origin)
end

get("/:currency_o/:currency_d") do
  @currency_o=params.fetch("currency_o").upcase
  @currency_d=params.fetch("currency_d").upcase
  erate_convert_url="https://api.exchangerate.host/convert?from=" + @currency_o + "&to=" +@currency_d+ "&amount=1&access_key=" + ENV.fetch("EXCHANGE_KEY")
  # erate_convert_url="https://api.exchangerate.host/convert?access_key=" + ENV.fetch("EXCHANGE_KEY") + "from=" + @currency_o + "&to=" + @currency_d +"&amount=1"
  #pp erate_convert_url
  @erate_convert_api=HTTP.get(erate_convert_url).to_s
  #pp erate_convert_api
  @parse_erate_c_body = JSON.parse(@erate_convert_api)
  #pp parse_erate_c_body.keys
  @keys_c= @parse_erate_c_body.keys
  # @info= @parse_erate_c_body.fetch("info")
  @result= @parse_erate_c_body.fetch("result")

  erb(:conversion)
end
