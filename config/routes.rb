Shareyourtest::Application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'index#index'

  match '/tests/purchase', to: 'tests#purchase', via: 'get'
  match '/tests/:permalink', to: 'tests#show', via: 'get,post'
  match '/tests/:permalink', to: 'tests#update', via: 'put,patch'
  match '/answers/:permalink/(:id)', to: 'answers#show', via: 'get'

  resources :users do
    resources :purchases
  end  


  resources :exams ,path: 'tests', controller: :tests do
    resources :questions
    resources :reviews
  end


  resources :user_answers
  resources :ratings, only: :update
  resources :exam_categories ,path: 'exams'

  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  
end
