NairaOverflow::Application.routes.draw do
  get "coming_soon/index"
  get 'users/categories', to: 'users#user_categories', as: :user_categories
  resources :page_invites, only: [:create]
  resources :pages do
    member { get :invite_friends            }
    member { get :edit_question             }
    member { put :update_question           }
    member { put :upload_page_logo          }
    member { put :upload_page_cover_picture }
    collection do
      post :questions
      get  'answer', as: 'new_answer'
      post 'create_answer'
      get 'invitess'
    end
  end

  put  'users/select_category/:id', to: "users#select_category", as: "select_category"
  get  "tags/index"
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  get  'questions/advise', to: 'questions#advise', :as => "question_advise"

  resources :categories
  resources :friendships
  resources :followers
  resources :comments
  resources :page_users
  resources :activities
  resources :user_category
  resources :tags, :only => [:index]

  resources :questions do
    member { post :vote }
    member { get  :accepted_answer }
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




  get 'users/who_is_online', to: 'users#who_is_online',       as: :online_users
  get 'people_to_follow', to: "users#people_to_follow",       as: :people_to_follow
  get 'users/:id/questions', to: "users#show_user_questions", as: :show_user_questions
  get 'users/:id/answers',   to: "users#show_user_answers",   as: :show_user_answers
  get 'users/:id/followers', to: "users#show_user_followers", as: :show_user_followers
  get 'users/:id/following', to: "users#show_user_following", as: :show_user_following
  get 'users/:id/favorites', to: "users#show_user_favorites", as: :show_user_favorites

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
