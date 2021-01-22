Rails.application.routes.draw do
  root 'welcome#index'
  get '/stocks/:id',to:'company#show'
  get '/stocks_minute/:id',to:'company#show_minute'
  get '/user/:id',to: 'company#user_show'
  get '/user_minute/:id',to: 'company#user_minute_show'
  get '/sell/:id',to:'share#delete'
  post '/buy',to:'share#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
