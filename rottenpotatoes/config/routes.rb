Rottenpotatoes::Application.routes.draw do
  resources :movies do
  #map '/' to be a redirect to '/movies'
  member do
    get 'search', to: 'movies#search'
  end
end
  root :to => redirect('/movies')
  #get 'same_director/:title' => 'movies#same_director', as: :same_director_movies_path
end