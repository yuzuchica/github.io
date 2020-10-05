require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

get '/' do
  erb :index
end

get '/signup' do
  erb :sign_up
end

post '/signup' do
  user = User.create!(
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
    )
  if user.persisted?
    session[:user] = user.id
  end
  redirect '/'
end

post '/signin' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
    redirect '/main'
  else
    redirect '/'
  end
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/main' do
  @works = current_user.works.sum(:work)
  @today = current_user.works.where("created_at >= ?", Time.now.beginning_of_day).sum(:work)
  erb :main
end

post '/time' do
  current_user.works.create!(
    work: params[:myM],
    user_id: current_user.id
    )
end

post '/money' do

end