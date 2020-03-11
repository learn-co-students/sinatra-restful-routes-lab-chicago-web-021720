class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes/new' do
    erb :new
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    @recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    recipe_by_id
    erb :show
  end

  get '/recipes/:id/edit' do
    recipe_by_id
    erb :edit
  end

  patch '/recipes/:id/edit' do
    recipe_by_id
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    recipe_by_id
    @recipe.destroy
    redirect "/recipes"
  end

  def recipe_by_id
    @recipe = Recipe.find_by_id(params[:id])
  end
end
