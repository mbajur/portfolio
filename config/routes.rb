Rails.application.routes.draw do
  comfy_route :cms_admin, path: "/admin"

  scope module: :admin, as: :admin do
    namespace :cms, as: :comfy_cms, path: 'admin' do
      resources :sites do
        resources :block_areas, controller: '/admin/block_areas' do
          resources :blocks, only: [:show, :create, :edit, :update, :destroy], controller: '/admin/blocks' do
            post :move_up, on: :member
            post :move_down, on: :member
          end
        end
      end
    end
  end

  # Ensure that this route is defined last
  comfy_route :cms, path: "/"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
