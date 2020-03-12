class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
      erb :new
  end

  get '/recipes/:id' do
      @recipe = Recipe.find(params[:id])
      erb :show
  end

  post '/recipes' do
      p params
      @recipe = Recipe.create(params)
      redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do
      p params
      @recipe = Recipe.find(params[:id])
      erb :edit
  end

  patch '/recipes/:id' do
      p params
      Recipe.find(params[:id]).update(params)
      redirect "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id' do
      p params
      Recipe.destroy(params[:id])
      redirect "/recipes"
  end

end