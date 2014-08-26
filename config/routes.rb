Dictionary::Application.routes.draw do
  devise_for :users
  resources :words
  get 'ask' => "words#ask"
  root 'welcome#index'
end
