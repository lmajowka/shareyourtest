Shareyourtest::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'index#index'

  match '/tests/:id/populate', to: 'tests#populate', via: 'get'
  match '/tests/purchase', to: 'tests#purchase', via: 'get'
  match '/tests/:permalink', to: 'tests#show', via: 'get,post'
  match '/tests/:permalink', to: 'tests#update', via: 'put,patch'
  match '/answers/:permalink/(:id)', to: 'answers#show', via: 'get'
  match '/tests-index/:permalink', to: 'tests#index', via: 'get'
  match '/tests-search/:permalink', to: 'tests#index', via: 'get'
  match '/purchases/:id', to: 'purchases#create', via: 'get'

  resources :users do
    resources :purchases
  end  


  resources :exams ,path: 'tests', controller: :tests do
    resources :questions
    resources :reviews
  end

  resources :comments
  resources :user_answers
  resources :ratings
  resources :exam_categories ,path: 'exams' do
    resources :embeddables
  end

  match '/hook', to: 'purchases#hook', via: 'post'

  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  match '/:not_found', to: 'application#not_found', via: 'get'

end
