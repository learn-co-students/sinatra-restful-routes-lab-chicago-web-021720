class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  def find_recipe(params)
    Recipe.all.select {|r| r.id == params[:id].to_i}[0]
  end
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do 
    erb :new
  end

  post "/recipes" do 
    @recipe = Recipe.new
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  get "/recipes/:id"  do 
    @recipe = find_recipe(params)
    erb :show
  end 

  delete "/recipes/:id" do 
    @recipe = find_recipe(params)
    @recipe.destroy
    redirect "/recipes"
  end

  get "/recipes/:id/edit" do 
    @recipe = find_recipe(params)
    erb :edit
  end 

  patch "/recipes/:id" do
    @recipe = find_recipe(params)
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end
end
