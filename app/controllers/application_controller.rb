
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

    set :views, "app/views"
    set :method_override, true

    configure do
        set :public_folder, 'public'
    end

    get '/' do
        erb :homepage
    end

    get '/articles' do
        @articles = Article.all
        erb :index
    end

    get '/articles/new' do
        erb :new
    end

    get '/articles/:id' do
        article_id = params[:id]
        @article = Article.find(article_id)
        erb :show
    end

    get "/articles/:id/edit" do
        @article = Article.find(params[:id])
        erb :edit
    end

    post '/articles' do
        title = params[:title]
        content = params[:content]
        article = Article.find_or_create_by(
            title: title,
            content: content)
            redirect "/articles/#{article.id}"
        end

    delete '/articles/:id' do
        Article.delete(params[:id])
        redirect '/articles'
    end

    patch "/articles/:id" do
        article = Article.find(params[:id])
        article.update(title: params[:title],
                     content: params[:content])
        redirect "/articles/#{article.id}"
    end



end

