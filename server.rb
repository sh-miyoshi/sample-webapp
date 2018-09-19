require 'sinatra'
require 'csv'

set :bind, '0.0.0.0'

get '/' do
  @population = nil
  erb :index
end

post '/search' do
  @country = params[:country]
  @population = 0
  if params["country"] then
    all_data = CSV.table("population.csv", encoding: "UTF-8")
    all_data.each do |data|
      if data[:country].include?(params["country"]) then
        @country = data[:country]
        @population = data[:population]
        break
      end
    end
  end
  logger.info @country.to_s + ": " + @population.to_s
  erb :index
end
