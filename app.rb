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
    { status: "ok", message: "Boom!" }.to_json
  end

  get '/' do
    { status: "error", message: "Try the endpoint '/counter'" }.to_json
  end

  get '/counter' do
    { status: "ok", counter: REDIS.incr(:hits) }.to_json
  end
end

