Shareyourtest::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'index#index'

  match '/tests/purchase', to: 'tests#purchase', via: 'get'
  match '/tests/:permalink', to: 'tests#show', via: 'all'
  match '/answers/:permalink', to: 'answers#show', via: 'get'

  resources :users
  resources :exams ,path: 'tests', controller: :tests do
    resources :questions
  end

  resources :user_answers

  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  
end
