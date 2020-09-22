Rails.application.routes.draw do
  resources :members
  root :to => "members#index"
  get 'match' => 'match#index', :as => :new_match
  post 'match/rank' => 'match#rank', :as => :rank_match
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
