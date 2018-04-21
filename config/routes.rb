Rails.application.routes.draw do

  root to: 'groups#search'

  get 'search', to: 'groups#search'

end
