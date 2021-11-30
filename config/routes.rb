Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'devise/sessions' => 'sessions#new', :as => :new_sessions
  end
  root 'books#index'
  post '/books/bookDetails' => 'books#bookDetails', :as => :bookDetails_books
  post '/books/mybooks' => 'books#mybooks', :as => :mybooks_books
  post '/books/adminaccess' => 'books#adminaccess', :as => :adminaccess_books
  post '/books/:id/edit' => 'books#edit', :as => :edit_books #edit book path
  patch 'books/:id', to: 'books#update' #edit book path


  post 'books/checkout', to: 'books#checkout', as: 'checkout_books'
  post 'books/return', to: 'books#return', as: 'return_books'

end
