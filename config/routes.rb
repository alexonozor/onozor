NairaOverflow::Application.routes.draw do

 
  get "tags/index"
  resources :categories

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  get 'questions/advise', to: 'questions#advise', :as => "question_advise"
  mount Ckeditor::Engine => '/ckeditor'
  resources :friendships
  resources :followers
  resources :alltags

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
 devise_for :users, :path => '/', :controllers => { :sessions => "sessions" }  
 get 'users/who_is_online', to: 'users#who_is_online', as: :online_users  
  
  resources :users do
  collection do
    get :tigers
  end
    member { put :ban }
  resources :favourites, :only => [:index]
  end

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
end