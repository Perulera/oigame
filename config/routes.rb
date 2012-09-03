Oigame::Application.routes.draw do

  # solucionar el tema de acceso por rol
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :sub_oigames, :path => "o" do
    resources :campaigns do
      member do
        post 'petition'
        get 'petition'
        get 'validate/:token' => 'campaigns#validate', :as => 'validate'
        get 'validated'
        post 'message'
        get 'message'
        get 'integrate'
        get 'widget'
        get 'widget-iframe.html' => 'campaigns#widget_iframe', :as => 'widget_iframe'
        get 'participants'
        post 'activate'
        post 'deactivate'
        post 'prioritize'
        post 'deprioritize'
        post 'archive'
        post 'new_comment'
      end
      collection do
        get 'moderated'
        get 'feed', :defaults => { :format => 'rss' }
        get 'archived'
        get 'search' => 'campaigns#search'
      end
    end
    get 'integrate'
    get 'widget'
    get 'widget-iframe.html' => 'sub_oigames#widget_iframe', :as => 'widget_iframe'
  end

  get 'donate' => 'donate#index', :as => 'donate'
  get 'donate/init' => 'donate#init', :as => 'donate_init'
  get 'donate/accepted' => 'donate#accepted'
  get 'donate/denied' => 'donate#denied'
  get 'answers' => redirect('/help')
  get 'help' => 'pages#help', :as => 'help'
  get 'tutorial' => 'pages#tutorial', :as => 'tutorial'
  get 'privacy-policy' => 'pages#privacy_policy', :as => 'privacy_policy'
  get 'contact' => 'pages#contact', :as => 'contact'
  post 'contact' => 'pages#contact', :as => 'contact'
  get 'contact/received' => 'pages#contact_received', :as => 'contact_received'
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }, :controllers => { :registrations => "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  # http://dev.af83.com/2012/06/04/request-authentication-from-the-router-with-devise.html
  authenticate :user do
    mount Tolk::Engine => '/translate', :as => 'tolk'
  end

  resources :campaigns do
    member do
      post 'petition'
      get 'petition'
      get 'validate/:token' => 'campaigns#validate', :as => 'validate'
      get 'validated'
      get 'participants'
      post 'message'
      get 'integrate'
      get 'message'
      get 'widget'
      get 'widget-iframe.html' => 'campaigns#widget_iframe', :as => 'widget_iframe'
      post 'activate'
      post 'deactivate'
      post 'prioritize'
      post 'deprioritize'
      post 'archive'
      post 'new_comment'
    end
    collection do
      get 'moderated'
      get 'feed', :defaults => { :format => 'rss' }
      get 'archived'
      get 'search' => 'campaigns#search'
    end
  end

  root :to => 'pages#index'

end
