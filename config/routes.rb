Rails.application.routes.draw do
  root 'welcome#index'
  get '/stocks/:id',to:'company#show'
  get '/stocks_minute/:id',to:'company#show_minute'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
