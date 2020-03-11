class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # root
  get '/' do
    erb :root
  end

  # index
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # create (form display)
  get '/recipes/new' do
    # Display the 'new' view with the create form
    erb :new
  end

  # create (form submission)
  post '/recipes' do
    # Create the new recipe
    recipe = Recipe.find_or_create_by(params)
    # Redirect to display the created recipe
    redirect "/recipes/#{recipe.id}"
  end

  # show
  get '/recipes/:id' do
    # Fetch the recipe to display
    @recipe = Recipe.find(params[:id])
    # Render the view to display the recipe
    erb :show
  end

  # edit (form display)
  get '/recipes/:id/edit' do
    # Fetch the recipe to update
    @recipe = Recipe.find(params[:id])
    # Render the view with the form to update the recipe
    erb :edit
  end

  # edit (form submission)
  patch '/recipes/:id' do
    # Fetch the recipe to update
    @recipe = Recipe.find(params[:id])
    # Update the recipe
    @recipe.update(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    )
    # Render the view to display the updated recipe
    redirect "/recipes/#{@recipe.id}"
  end

  # delete
  delete '/recipes/:id' do
    # Fetch the recipe to delete
    recipe = Recipe.find(params[:id])
    # Delete the recipe
    recipe.destroy
    # Render the index of all recipes (it will no longer show up)
    redirect '/recipes'
  end

end
