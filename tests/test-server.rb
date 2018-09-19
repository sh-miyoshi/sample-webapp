require './server'
require 'test/unit'
require 'rack/test'
require 'csv'

class ServerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_root
    get '/'
    params = {}
    rack_env = {}

    assert last_response.ok?
  end

  def test_search
    post '/search', :country => 'Japan'

    assert last_response.ok?
    assert last_response.body.include?('Japan')

    all_data = CSV.table("population.csv", encoding: "UTF-8")
    all_data.each do |data|
      if data[:country] == 'Japan' then
        assert last_response.body.include?(data[:population].to_s)
        break
      end
    end
  end

  def test_search_no_country
    post '/search', :country => 'illegal_country'

    assert last_response.ok?
    assert last_response.body.include?('no data of the country')
  end
end
