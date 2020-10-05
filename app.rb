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
  @monies = current_user.histories.sum(:money)
  @today = current_user.works.where("created_at >= ?", Time.now.beginning_of_day).sum(:work)
  @one = current_user.works.where(created_at: 1.day.ago.all_day).sum(:work)
  @two = current_user.works.where(created_at: 2.day.ago.all_day).sum(:work)
  @three = current_user.works.where(created_at: 3.day.ago.all_day).sum(:work)
  @four = current_user.works.where(created_at: 4.day.ago.all_day).sum(:work)
  erb :main
end

post '/time' do
  current_user.works.create!(
    work: params[:myM].to_i*10,
    user_id: current_user.id
    )
end

post '/money' do
  current_user.histories.create!(
    money: params[:money],
    purpose: params[:purpose]
  )
  redirect '/main'
end

get '/history' do
  @histories = History.all
  erb :history
end

get '/delete/:id' do
  History.find(params[:id]).destroy
  redirect '/history'
end
