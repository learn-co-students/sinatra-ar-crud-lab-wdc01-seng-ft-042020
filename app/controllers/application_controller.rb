
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    title = params[:title]
    content = params[:content]
    Article.update(title: title, content: content)
    redirect "/articles/#{params[:id]}"
  end

  post '/articles' do
    article = Article.create(title: params[:title], content: params[:content])
    redirect "articles/#{article.id}"
  end

  delete '/articles/:id' do 
    Article.delete(params[:id])
    redirect "/articles"
  end
  
end
