Rails.application.routes.draw do
  root 'welcome#splash'
  get '/scan',to: 'welcome#index'
  get '/all_users_minutes',to:'welcome#all_users_minutes'
  get '/all_users',to:'welcome#all_users'
  get '/splash2',to: 'welcome#splash2'
  post '/login', to:'welcome#create_session'
  get '/stocks/:id',to:'company#show'
  get '/stocks_minute/:id',to:'company#show_minute'
  get '/user/:id',to: 'company#user_show'
  get '/user_minute/:id',to: 'company#user_minute_show'
  get '/sell/:id',to:'share#delete'
  post '/buy',to:'share#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
