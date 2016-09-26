Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies
  root :to => redirect('/movies')
  # Route that posts 'Search TMDb' form
  post '/movies/search_tmdb'
end
