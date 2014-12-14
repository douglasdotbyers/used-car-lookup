Rails.application.routes.draw do

  root "used_cars#index"

  get "index"  => "used_cars#index"
  get "search" => "used_cars#search"

end
