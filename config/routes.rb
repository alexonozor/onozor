NairaOverflow::Application.routes.draw do

  put 'users/select_category/:id', to: "users#select_category", as: "select_category"
  get "tags/index"
  resources :categories

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  get 'questions/advise', to: 'questions#advise', :as => "question_advise"

  resources :friendships
  resources :followers
  resources :comments
  resources :tags, :only => [:index]

  resources :questions do
    member {post :vote}
    collection do
      get :hot
      get :active
      get :unanswered
      get :answered
      get :overflowed
      get :latest
    end
  end
devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
    get 'edit_user/:option' => "users#edit_user", as: :edit_user
    post 'edit_user/:option' => "users#update_user", as: :update_user
    collection do
      get :tigers
    end
    member { put :ban }
    resources :favourites, :only => [:index]
    resources :direct_messages
  end




 get 'users/who_is_online', to: 'users#who_is_online', as: :online_users



 resources :relationships, only: [:create, :destroy]

  get 'tags/:tag', to: 'questions#index', as: :tag


  resources :favourites, :only => [:toggle] do
    member do
      post :toggle
      get :toggle
    end
  end

  resources :answers  do
    member {post :vote}
  end

   root 'questions#index'
   get '/about' => 'about#index', as: :about
end
