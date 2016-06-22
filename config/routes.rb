Rails.application.routes.draw do
  
  resources :properties do
    collection do
     get "get_image"
    end
  end
  
    match "/site/show_properties" => "site#show_properties", via: :get

end
