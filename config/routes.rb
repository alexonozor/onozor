NairaOverflow::Application.routes.draw do
  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      get  'question/:id/comments', to: 'questions#comments'
      get  'answer/:id/comments', to: 'answers#comments'
      get  'question/:id/answers', to: 'questions#answers'
      put  'comment/:id', to: 'comments#update'
      put  'answer/:id', to: 'answers#update'
      post 'sessions/create', to: 'sessions#create'
      get 'user/login-token/:token', to: 'users#login'
      resources :relationships, only: [:create, :destroy]
      post  'subscribe/communities', to: 'user_category#create'
      delete  'unsubscribe/communities/:category_id', to: 'user_category#destroy'
      resources :answers,  except: [:edit, :new, :index, :update, :create, :new, :show] do
        member do 
          get :answer_voters
          post :vote
        end
      end

      
      resources :questions, except: [:edit, :new] do
        member do 
          get :question_voters
          post :vote
        end
        resources :comments, except: [:edit, :new, :update]
        resources :answers,  except: [:edit, :new, :update]
      end
      resources :users do
        member do
          get :user_categories
          get :questions
          get :answers
          get :followers
          get :following
          get :favorites
        end
      end
      resources :categories do
        member do
          get :get_questions
        end
      end

      resources :favourites, :only => [:toggle] do
        member do
          # post :toggle
          get :toggle
        end
      end
    end
  end

  # mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks, :registrations, :passwords]

 #  resources :tags
 #  resources :user_tag
 #  get "coming_soon/index"
 #  get 'users/categories', to: 'users#user_categories', as: :user_categories
 #  resources :page_invites, only: [:create]
 #  resources :pages do
 #    member { get :invite_friends            }
 #    member { get :edit_question             }
 #    member { put :update_question           }
 #    member { put :upload_page_logo          }
 #    member { put :upload_page_cover_picture }
 #    collection do
 #      post :questions
 #      get  'answer', as: 'new_answer'
 #      post 'create_answer'
 #      get 'invitess'
 #    end
 #  end
 #
 #  put  'users/select_category/:id', to: "users#select_category", as: "select_category"
 #  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
 #  get  'questions/advise', to: 'questions#advise', :as => "question_advise"
 #
 #  resources :categories do
 #    member do
 #      get :tags
 #    end
 #  end
 #  resources :friendships
 #  resources :followers
 #  resources :comments
 #  resources :page_users
 #  resources :activities
 #  resources :user_category
 #  resources :questions do
 #    member { post :vote }
 #    member { get  :accepted_answer }
 #    collection do
 #      get :hot
 #      get :active
 #      get :unanswered
 #      get :answered
 #      get :overflowed
 #      get :latest
 #    end
 #  end
 #
 #
 #  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
 #  resources :users do
 #    get 'edit_user/:option' => "users#edit_user", as: :edit_user
 #    post 'edit_user/:option' => "users#update_user", as: :update_user
 #    collection do
 #      get :tigers
 #    end
 #    member { put :ban }
 #    resources :favourites, :only => [:index]
 #    resources :direct_messages
 #  end
 #
 #
 #
 #
 #  get 'users/who_is_online', to: 'users#who_is_online',       as: :online_users
 #  get 'people_to_follow', to: "users#people_to_follow",       as: :people_to_follow
 #  get 'users/:id/questions', to: "users#show_user_questions", as: :show_user_questions
 #  get 'users/:id/answers',   to: "users#show_user_answers",   as: :show_user_answers
 #  get 'users/:id/followers', to: "users#show_user_followers", as: :show_user_followers
 #  get 'users/:id/following', to: "users#show_user_following", as: :show_user_following
 #  get 'users/:id/favorites', to: "users#show_user_favorites", as: :show_user_favorites
 #
 # resources :relationships, only: [:create, :destroy]
 #
 #
 #
 #
 #  resources :favourites, :only => [:toggle] do
 #    member do
 #      post :toggle
 #      get :toggle
 #    end
 #  end
 #
 #  resources :answers  do
 #    member {post :vote}
 #  end
 #
 #   root 'questions#index'
 #   get '/about' => 'about#index', as: :about
end
