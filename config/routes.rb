Rails.application.routes.draw do

  root to: 'groups#index'

  get 'search', to: 'groups#index'
  get 'group/:group_urlname/events', to: 'group_events#index', as: :group_events_index

end
