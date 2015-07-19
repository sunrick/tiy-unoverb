Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # USER ROUTES
  post 'users/signup', to: 'users#signup'
  post 'users/login', to: 'users#login'
  delete 'users/delete', to: 'users#delete'
  get 'users/profile', to: 'users#show'
  put 'users/profile', to: 'users#update'
  put 'users/password', to: 'users#password'

  # CLASSROOM ROUTES
  post 'classrooms/create', to: 'classrooms#create'
  get 'classrooms/:id', to: 'classrooms#show_classroom'
  put 'classrooms/:id', to: 'classrooms#update'
  delete 'classrooms/:id', to: 'classrooms#delete'
  get 'classrooms', to: 'classrooms#get_classrooms'
  get 'user/classrooms', to: 'classrooms#show_user_classrooms'

  # CLASSROOM REQUEST ROUTES
  post 'classrooms/:id/join', to: 'classrooms#request_join'
  get 'classrooms/:id/requests', to: 'classrooms#get_requests'
  post 'requests/:id/', to: 'classrooms#process_request'

  # EXERCISE ROUTES
  post 'classrooms/:id/exercise', to: 'exercises#create'
  get 'classrooms/:id/exercises', to: 'exercises#get_exercises'
  delete 'exercises/:id', to: 'exercises#delete'
  put 'exercises/:id', to: 'exercises#update'
  get 'exercises/:id', to: 'exercises#get_exercise'

  # QUESTION ROUTES
  post 'exercises/:id/question', to: 'questions#create'
  get 'exercises/:id/questions', to: 'questions#get_questions'
  get 'questions/:id', to: 'questions#get_question'
  put 'questions/:id', to: 'questions#update'
  delete 'questions/:id', to: 'questions#delete'

  # VERB ROUTES
  get 'verbs/search', to: 'verbs#search'

  # TENSE ROUTES
  get 'tenses', to: 'tenses#get_tenses'

  # FORM ROUTES
  get 'forms', to: 'forms#get_forms'

  # GAME ROUTES
  post 'exercises/:id/games/save', to: 'games#save'
  get 'exercises/:id/games/play', to: 'games#play'
  get 'games/:id', to: 'games#get_game'

  # SCORE ROUTES
  get 'scores/exercise/:id', to: 'scores#exercise'
  get 'scores/classroom/:id', to: 'scores#classroom'
  get 'scores/user', to: 'scores#user'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
