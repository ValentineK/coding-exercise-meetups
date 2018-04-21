Rails.application.routes.draw do

  root to: 'groups#search'

  get 'group/:group_urlname/events', to: 'group_events#index', as: :group_events_index
  get 'search', to: 'groups#search'

end
