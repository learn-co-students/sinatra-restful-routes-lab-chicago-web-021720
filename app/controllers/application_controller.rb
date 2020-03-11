class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do
    @recipes = Recipe.all 
    erb :index
  end

  get '/recipes/new' do 
    erb :new
  end 

  post '/recipes' do 
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{@recipe.id}"
  end 

  get '/recipes/:id/edit' do 
    find_recipe
    erb :edit
  end 
  
  patch '/recipes/:id' do 
    find_recipe
    @recipe.assign_attributes(name: params[:name], ingredients: params[:ingredients],cook_time: params[:cook_time])
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end 

  get '/recipes/:id' do
    find_recipe
    erb :show
  end

  delete '/recipes/:id' do
    find_recipe
    @recipe.destroy
    redirect "/recipes"
  end 

  def find_recipe
    @recipe = Recipe.find(params[:id])    
  end 


end
