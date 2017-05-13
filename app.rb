# Encoding: utf-8
require 'bundler'

Bundler.require

class Application < Sinatra::Base

  configure do
    set :show_exceptions, false
    set :server, :puma

    REDIS = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db: ENV['REDIS_DB'])
  end

  before do
    content_type :json
  end

  error do
    { message: "Boom!" }.to_json
  end

  get '/counter' do
    { counter: REDIS.incr(:hits) }.to_json
  end
end

